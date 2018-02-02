//Logs all the calls being made to javascript
var addToLog = function(id, txt) {
    $(id + " .logs").append("<br>" + txt);
  };

function RegisterPlayer(){
  Game.GetPlayerStats(123);
  var name = document.getElementById("fname").innerHTML;
  var accountNo = document.getElementById("address").value;
  var actualWeb3AccNo = web3.eth.accounts[0];  
  var converttedToIntAccNo = parseInt(accountNo);
  Game.methods.RegisterPlayer(name,actualWeb3AccNo).send();
document.getElementById("overlay").style.display = "none";
document.getElementById("MainUI").style.display = "block"
}
window.onload = function() {
  document.getElementById("MainUI").style.display = "none";
  document.getElementById("overlay").style.display = "block";
  
  RegisterPlayer();
};
