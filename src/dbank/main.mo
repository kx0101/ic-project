import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  // stable means that whenever we deploy our app we want to keep the value as it was
  // for example if we update our container the variable currentValue will still be 
  // the value it was before we deployed again.
  // Starting 300 -> Adding 100 -> 400 -> Redeploy -> 300 again.
  // WITH stable : Starting 300 -> Adding 100 -> 400 -> Redeploy -> 400!

  stable var currentValue: Float = 300; // initialize 300
  currentValue := 300; // replaces 300 with 100
  Debug.print(debug_show(currentValue));

  // by using := no matter if the variable is stable or not, it will still update it
  // so the next time we redeploy the line 9 won't run again meaning that
  // the 300 will become 100 because of line 10 which replaces the value of currentValue

  let id = 123123123123; // let = data inside won't change
  stable var startTime = Time.now(); // nanoseconds since program started
  startTime := Time.now();
  Debug.print(debug_show(startTime));

  // Debug.print(debug_show(currentValue)); 
  // debug.print can only print texts so for numbers
  // we used debug_show

  // function (needs ; at the end) 
  // that increases currentValue by 1 and prints the new value.
  // Nat = Natural Number that is positive 0...+infinity

  public func topUp(amount: Float) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount: Float) {
    // current value is Float, amount is Float, tempValue is Float
    // telling our program that (currentValue - amount) is an Float number.
    let tempValue: Float = currentValue - amount;

    if (tempValue >= 0){
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Amount too large, currentValue less than zero.")
    }
  };

  // dfx canister call -project name- -function-
  // func topUp() is private by default so we need to make it public
  // so we can use it from the outside for example terminal.

  // dfx canister id __Candid_UI allows us to interact with the web app(Candid)
  // the command will provide us an id which will use as a query for example
  // localhost:port/?canisterId=<id>
  // then, we run dfx canister id <project name> and we get another id which se put
  // into the empty search box.
  // That way we can test any function we have created inside the canister
  // just by clicking a button.

  public query func checkBalance(): async Float {
    return currentValue; // Read-only operation
  };

  // if we want to make a function super fast we're using the keyword query 
  // checkBalance(): Float , means that it has a return value of Float.
  // We ALWAYS need the keyword async whenever a function has a return value.

  // Compound Interest
  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime; // from the beginning of the program time
    // up to now (in nanoseconds)
    let timeElapsedS = timeElapsedNS / 1000000000; // converting it to seconds
    
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));

    // we need to reset the startTime every time we compound.
    startTime := currentTime;

  }

}