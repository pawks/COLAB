1.	Write an ARM assembler program that increments the elements of a vector of size 100. After incrementing, copy the vector to a different part of the memory and add the two vectors and store the result where first vector was in. Repeat the above procedure three more times once with Multiplication (instead of ADD) by 5, once with divide by 4, and finally by adding 16384. Finally copy the vector to a file. Optimize code for execution time using appropriate cache configuration and choosing the appropriate assembly instruction. Solution with best execution time will be recognized suitably.
Due on Feb 28th or March 1st
Plot your observations using Excel Graphs for problem 2, 3, and 4
2.	Run the above program (1) with unified cache with direct mapping and Write back. For the following combination of cache size and block size measure the miss rate.  Plot your results and provide your observation. Due on March 3rd or 4th.
cache	 Test 1	     Test 2
Size  Block Size	Block Size
128	     16	         32
256	     16	         32
512	     16	         32
1024	   16	         32
2K	     16	         32
4K	     16	         32
8K	     16	         32
3.	Run the above program (1) with split cache with direct mapping and Write back. For the following combination of cache size and block size measure the hit and miss rate.  Plot your results and provide your observation. Due on March 3rd or 4th.

4.	Run the above program (1) with split cache with associative mapping and Write back. For the following combination of cache size and block size measure the hit and miss.  Plot your results and provide your observation. Due on March 3rd or 4th.

OR (Either Problem 4 or Problem 5 - one will do, however, problem 5 includes bonus point of 5!)
5.	Develop a set of ARM subroutines to ADD and SUBTRACT floating point IEEE 754 numbers. Read the inputs from a file, write your results to STDOUT.
