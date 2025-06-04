object Sol {

  def solution(a: Array[Int], b: Array[Int]): Double = {
    a.zip(b).map((i,j) => scala.math.pow((i-j).abs,2)).sum / a.length
  }
}