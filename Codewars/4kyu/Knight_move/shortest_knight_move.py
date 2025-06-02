from typing import Tuple, List, Optional
from collections import deque
from dataclasses import dataclass


def knight(p1, p2):
    offsets = [(-2,-1),(-2,1),(-1,2),(-1,-2),(1,2),(1,-2),(2,-1),(2,1)]
    
    columns = 'abcdefgh'
    
    @dataclass
    class Node:
        pos: Tuple[int, int]
        parent: Optional[object]
        
        def get_path(self):
            result = [self.pos]
            
            if self.parent is not None:
                result.extend(self.parent.get_path())
            return result
    
    def _decode_position(pos: str)-> Tuple:
        return columns.index(pos[0]),int(pos[1])-1
    
    def _get_moves_from_position(pos: Tuple[int,int]) -> List:
        possible_moves_to = []
        
        for offset in offsets:
            result = (pos[0] + offset[0], pos[1] + offset[1])
            
            if 0 <= result[0] < 8 and 0 <= result[1] < 8:
                possible_moves_to.append(result)
        return possible_moves_to
       
    to_check = deque()
    to_check.append(Node(_decode_position(p1),None))
    checked = set()
    counter = 0
    end = _decode_position(p2)
    
    while to_check:
        current = to_check.popleft()

        
        if current.pos == end:
            return len(current.get_path())-1
        
        for move in _get_moves_from_position(current.pos):
            if not move in checked:
                checked.add(move)
                to_check.append(Node(move,current))

    
    return None