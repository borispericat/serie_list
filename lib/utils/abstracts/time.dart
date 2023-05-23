import 'dart:core';

String readTImeStamp(int timeInt) {
  var now = DateTime.now();

  var nowStamps = (now.millisecondsSinceEpoch / 1000).round();

    var intervall = now.add(const Duration(minutes: 1));
    if (intervall == now) {
      
    }
  
  var diff = nowStamps - timeInt;
  if (diff == 0) {
    return 'just now';
  }

  if ((diff/60) < 60) {
      return '${diff%60} seconds ago';

  } 
 
  return '${(diff/60).round()} min ${diff%60} seconds ago';

  

}