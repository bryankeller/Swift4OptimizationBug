//  Created by Bryan Keller on 10/12/18.

func foo() -> UnsafeBufferPointer<UInt8> {
  let value: UInt8
  
  /*
   This condition is always true, so value will always be set to 6.
   Note that the condition is complex enough (string concatenation and comparison) that
   the else clause can't be optimized away at compile time.
 */
  if "foo" == "f" + "oo" {
    value = 6 // Always runs
  } else {
    value = 9 // Never runs
    
    /*
     Despite this being a dead code path, adding in this print statement
     (while compiling with -O or -Osize) will cause a garbage buffer pointer to be returned.
    */
    
    print("")
  }
  
  let array = [value] // Create an Array<UInt8> with one value, 6
  let arrayPointer = UnsafePointer<UInt8>(array) // Create a pointer to array
  let bufferPointer = UnsafeBufferPointer<UInt8>(start: arrayPointer, count: 1) // Create a buffer pointer of length 1, starting at arrayPointer
  return bufferPointer // Return the buffer pointer
}

print("This should always print 6... actually printing \(foo()[0])")
