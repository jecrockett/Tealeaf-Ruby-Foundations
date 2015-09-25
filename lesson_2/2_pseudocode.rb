#Practice with pseudocode

#1 - casual --- method that returns sum of two integers
ask for integer from user
convert string response to integer
save answer to integer1
ask for another integer from the user
convert string response to integer
save that answer as integer2
perform addition and save result to new variable
print new variable

#1 - formal
START

GET answer1
SET integer1 = answer1 converted to integer

GET answer2
SET integer2 = answer2 converted to integer

SET sum = integer1 + integer2

PRINT sum

END

#2 - casual --- method that takes array of strings, returns one concatentated

given an array of strings
call the join method to concatenate the strings
print the complete string

#2 - formal

START

#Given an array of strings

SET answer = given array .join
PRINT answer

END

#3 - casual --- takes array of integers, returns array with every other element

given an array of integers
iterate through the array indices
if remainder of index divided by 2 is not 0
  delete the index
else
  go to the next index

  #concerned that if it deletes index 1, for example, then deletes it,
  #the value at index 2 shifts into index 1 and it ends up deleting the
  #whole rest of the array. would need to test and possibly switch strategy.


#3 - formal
START

#given a collection of integers: "numbers"

WHILE iterator < array indicies
  IF index of iterator divided by two does not equal 0
    delete the value at that index
  ELSE
    move on to the next index

  PRINT the array

END