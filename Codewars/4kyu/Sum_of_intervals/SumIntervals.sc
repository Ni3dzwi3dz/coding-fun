def sumOfIntervals(intervals: List[(Int, Int)]): Int = 
    intervals
      .sortBy(_._1)
      .foldLeft(List(): List[(Int, Int)]){ (acc, current) =>
        if ((acc.length > 0) && (current._1 <= acc.head._2)){
          (acc.head._1, acc.head._2.max(current._2)) :: acc.tail
      } else {current :: acc}
      }
      .map((i,j) => j-i)
      .sum