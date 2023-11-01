
#!/bin/bash


echo "--------------------------"
echo "User Name: LeeJunSu"
echo "Student Number: 12224384"
echo "[ MENU ]"
echo "1. Get the data of the movie identified by a specific 'movie id' from 'u.item'"
echo "2. Get the data of action genre movies from 'u.item'"
echo "3. Get the average 'rating' of the movie identified by specific 'movie id' from 'u.data'"
echo "4. Delete the 'IMDb URL' from 'u.item'"
echo "5. Get the data about users from 'u.user'"
echo "6. Modify the format of 'release date' in 'u.item'"
echo "7. Get the data of movies rated by a specific 'user id' from 'u.data'"
echo "8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'"
echo "9. Exit"
echo "--------------------------"

while true; do
    read -p "Enter your choice [ 1-9 ]: " num

    case $num in
        1)
            read -p "Please enter 'movie id'(1~1682): " movie_id
            grep "^$movie_id|" u.item
            ;;
        2)
            read -p "Do you want to get the data of ‘action’ genre movies from 'u.item’?(y/n): " confirm
            if [ "$confirm" == "y" ]; then
                awk -F"|" '$7 == "1" {print $1, $2}' u.item | head -10
            fi
            ;;
        3)
            read -p "Please enter 'movie id'(1~1682): " movie_id
            awk -F"\t" -v id="$movie_id" '$2 == id { total += $3; count++ } END { if (count > 0) print total/count; else print "No ratings found" }' u.data
            ;;
        4)
            read -p "Do you want to delete the ‘IMDb URL’ from ‘u.item’?(y/n): " confirm
            if [ "$confirm" == "y" ]; then
                awk -F"|" '{
                    $5="";
                    printf "%s|%s|%s|", $1, $2, $3;
                    for (i=6; i<=NF; i++) {
                        printf "%s", $i;
                        if (i != NF) {
                            printf "|";
                        }
                    }
                    print "";
                }' u.item | head -10
            fi
            ;;
        5)
            read -p "Do you want to get the data about users from ‘u.user’?(y/n): " confirm
            if [ "$confirm" == "y" ]; then
                awk -F"|" '{printf "user %s is %s years old %s %s\n", $1, $2, $3, $4}' u.user | head -10
            fi
            ;;
        6)
            read -p "Do you want to Modify the format of ‘release date’ in ‘u.item’?(y/n): " confirm
            if [ "$confirm" == "y" ]; then
                awk -F"|" -v OFS="|" '{
                    split($3, date, "-");
                    months["Jan"] = "01"; months["Feb"] = "02"; months["Mar"] = "03"; months["Apr"] = "04";
                    months["May"] = "05"; months["Jun"] = "06"; months["Jul"] = "07"; months["Aug"] = "08";
                    months["Sep"] = "09"; months["Oct"] = "10"; months["Nov"] = "11"; months["Dec"] = "12";
                    $3 = date[3] months[date[2]] date[1];
                    print;
                }' u.item | tail -10
            else
                tail -10 u.item
            fi
            ;;
        7)
            read -p "Please enter the ‘user id’(1~943): " user_id
            movie_ids=$(awk -F"\t" -v uid="$user_id" '$1 == uid {print $2}' u.data | sort -n | tr '\n' '|')
            echo "$movie_ids" | sed 's/|$//' 

            awk -F"\t" -v uid="$user_id" '$1 == uid {print $2}' u.data | sort -n | head -10 | while read -r movie_id; do
                grep "^$movie_id|" u.item | awk -F"|" '{print $1 "|" $2}'
            done
            ;;
        8)
            read -p "Do you want to get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'?(y/n): " response
            if [ "$response" == "y" ]; then
                user_ids=$(awk -F"|" '$2 >= 20 && $2 <= 29 && $4 == "programmer" {print $1}' u.user)
                for user_id in $user_ids; do
                    awk -F"\t" -v uid="$user_id" '$1 == uid {print $2 "\t" $3}' u.data
                done | sort -k1,1n | awk '
                {
                    ratings[$1] += $2;
                    count[$1]++;
                }
                END {
                    for (movie_id in ratings) {
                        avg_rating = ratings[movie_id] / count[movie_id];
                        printf "%d %.5f\n", movie_id, avg_rating;
                    }
                }' | sort -k1,1n | sed 's/0\{1,\}$//; s/\.$//'
            fi
            ;;
        9)
            echo "Bye!"
            exit 0
            ;;
        *)
            echo "Invalid num!"
            ;;
    esac
done
