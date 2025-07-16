from typing import List

def format_duration(seconds):
    if seconds == 0:
        return 'now'
    
    def _get_number_of_intervals(divider: int, duration: int):
        return duration // divider, duration % divider
    
    def _format_message_part(name: str, count: int) -> str:
        if count > 1:
            name += 's'
        
        return f'{count} {name}'
    
    def _format_return_message(parts: List) -> str:
        if len(parts) == 1:
            return parts[0]
        
        return f'{", ".join(parts[:-1])} and {parts[-1]}'
        
    durations = [('year', 31536000), ('day', 86400), ('hour', 3600),('minute', 60)]
        
    result = []
    
    for dur in durations:
        count, seconds = _get_number_of_intervals(dur[1], seconds)
        result.append((dur[0],count))
        
    result.append(('second',seconds))
                      
    message_parts = [ _format_message_part(*dur) for dur in result if dur[1] > 0]
    
    return _format_return_message(message_parts)