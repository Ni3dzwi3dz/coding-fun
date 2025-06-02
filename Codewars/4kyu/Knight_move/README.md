**Kata link:** [Shortest knight path](https://www.codewars.com/kata/549ee8b47111a81214000941)

**Description**
Given two different positions on a chess board, find the least number of moves it would take a knight to get from one to the other. The positions will be passed as two arguments in algebraic notation. For example, knight("a3", "b5") should return 1.

The knight is not allowed to move off the board. The board is 8x8.

For information on knight moves, see https://en.wikipedia.org/wiki/Knight_%28chess%29

For information on algebraic notation, see https://en.wikipedia.org/wiki/Algebraic_notation_%28chess%29

(Warning: many of the tests were generated randomly. If any do not work, the test cases will return the input, output, and expected output; please post them.)

**Comment**
Chess board positions and moves from one to the other can be represented as a graph-
positions are the nodes and possible moves are the edges.

Therefore, finding a shortest path beetween two nodes can be solved using [breadth-first search](https://en.wikipedia.org/wiki/Breadth-first_search)

The algorithm implementation was based on [a book by David Kopec](https://www.manning.com/books/classic-computer-science-problems-in-python)