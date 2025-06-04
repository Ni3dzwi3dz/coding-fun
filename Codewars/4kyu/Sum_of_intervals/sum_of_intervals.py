from typing import List, Tuple

def sum_of_intervals(intervals: List[Tuple[int, int]]) -> int:
    # Sort intervals by their start points
    intervals.sort()
    
    # Merge overlapping intervals
    merged_intervals = []
    for start, end in intervals:
        if not merged_intervals or merged_intervals[-1][1] < start:
            # No overlap, add the interval
            merged_intervals.append((start, end))
        else:
            # Overlap, merge intervals
            merged_intervals[-1] = (merged_intervals[-1][0], max(merged_intervals[-1][1], end))
    
    # Calculate the total length of merged intervals
    return sum(end - start for start, end in merged_intervals)