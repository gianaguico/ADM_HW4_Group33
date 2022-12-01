#! /bin/zsh

#Task 1
echo
echo Location for the maximum number of purchases been made:

cut -d "," -f 5,9 bank_transactions.csv | sed "s/[^A-Za-z]//g" > locations_amount.txt

sort locations_amount.txt | uniq -c > common_locations.txt

top=$(sort -k 1 -n -r common_locations.txt | head -1 | cut -d " " -f 2)

tot_amount=0
for i in $(cut -f 5,9 bank_transactions.csv | grep "$top" | cut -d "," -f 2);do
	tot_amount=$(bc <<< "$tot_amount + $i")
done

echo Location: $top 
echo Total of purchases in INR: $tot_amount INR

echo --------------------------------------------------------------------------------------

#Task 2

echo
echo Number of females:
#retrieve only Females customers, and count how many of them 
numb_females=$(cut -d "," -f 4 bank_transactions.csv | grep "F" | wc -l)
echo $numb_females

echo Number of males:
#retrieve only Males customers, and count how many of them
numb_males=$(cut -d "," -f 4 bank_transactions.csv | grep "M" | wc -l)
echo $numb_males


#In order to save some time, we've already computed the total expenditure both for males and females, which are respectively 1232845753.27 INR and 485254217.07 INR
#If you want to check by yourself, just uncomment the following lines.

#f_count=0

#for i in $(cut -d "," -f 4,9 bank_transactions.csv | grep "F" | cut -d "," -f 2);do
#	f_count=$(bc <<< "$f_count + $i")
#done

#m_count=0

#for j in $(cut -d "," -f 4,9 bank_transactions.csv | grep "M" | cut -d "," -f 2);do
#	m_count=$(bc <<< "$m_count + $j")
#done
#Total expenditure of F: 485254217.07
#Total expenditure of M: 1232845753.27

f_count=485254217.07
m_count=1232845753.27
echo
if [ $(echo "$f_count > $m_count"|bc -l) -eq 1 ]; then
        echo Females spend more than Males.
        echo Females spent: $f_count
else
        echo Males spend more than Females.
        echo Males spent: $m_count
fi

echo --------------------------------------------------------------------------------------

#Task 3
echo
echo The highest transaction amount, thus the highest average transaction amount, is:
highest=$(cut -d "," -f 9 bank_transactions.csv | sort --numeric -r | head -1)
echo $highest

len=$(cut -d "," -f 9 bank_transactions.csv | wc -l)
echo
echo The highest average is:
calc() { awk "BEGIN{ printf \"%.2f\n\", $* }"; }
calc $highest/$len

echo
echo Customer Information:

cut -d "," -f 1,2,3,4,5,6,7,8,9 bank_transactions.csv | grep $highest


#Summary:
#This section is a brief explanation of what has been done in this script.
#Task 1: We've basically sort locations by the number of their occurrences in the dataset, i.e. we've grouped them together.
#Then through the grep command we found all the transacations made in that locations, and summed them up.
#Since Bash can work only with integer values, and in our dataset we have float values, we have used bc command, which stands for Basic Calculator, that
#in order to perform arithmetical operations with float values.

#Task 2: The first step is to find the fraction of females and males in our dataset, we have found that the number of males is almost three times 
#bigger than the number of females. This led us to think that males spend more than females.
#To doublecheck our hypothesis, through the grep command we retrieved only females and males informations and summed,for each gender, the total 
#amount in INR. Since we are dealing we huge numbers, thus huge number of iterations, we have already computed these opearations, and we discovered that 
#the total amount of transaction made by males is 1232845753.27, and 485254217.07 for females.
#In conclusion we have foud that our hypothesis was correct, and we can say that males spend more than females.

#Task 3: In order to find the customer with the highest average transaction amount, we've retrieved the highest transaction amount and divided by the
#total number of transaction amounts. In order to compute the average we've defined a function called calc which computes the division between float 
#values.
