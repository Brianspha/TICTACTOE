var playerSymbol;
var enemySymbol;

//Function for loging messages returned by method execution results
var addToLog = function(txt) {
  $(".console").append("<br>" + txt);
};

(function ($) {
  'use strict';
  jQuery(document).ready(function () {

$("#submit").click(function(e) {
  e.preventDefault();
var name = document.getElementById("name").value;
  var accountNo = document.getElementById("address").value;
  //var converttedToIntAccNo = parseInt(accountNo);
    //var actualWeb3AccNo = web3.eth.accounts[converttedToIntAccNo];  
  if (EmbarkJS.isNewWeb3()) 
  {
    Game.methods.RegisterPlayer("ass",web3.eth.defaultAccount).call({from: web3.eth.defaultAccount,gas:3000000},function(err, value) {
      alert(value);
    });
    //var results=Game.methods.RegisterPlayer("ass",web3.eth.defaultAccount).send({from: web3.eth.defaultAccount,gas:3000000});
   /* var game =Game.methods.RegisterPlayer("Test message",web3.eth.defaultAccount).call(function(code){
      console.info("Successfully Registerd User");
      console.log(results);
      alert(results);
      addToLog("Game.methods.RegisterPlayer(ass,web3.eth.defaultAccount).send({from: web3.eth.defaultAccount,gas:3000000});");
    }).catch(function(error){
      alert(error.message);
    });
    */
    }
    else
     {
       Game.RegisterPlayer(name,actualWeb3AccNo).call();
      }
      document.getElementById("overlay").style.display = "none";
      document.getElementById("ChooseXorO").style.display = "block";
  });
   //Symbol selection Window X or O    
  $("#choose-x").on("click", function() {
    playerSymbol = "X";
    enemySymbol = "O";
    $("#ChooseXorO").fadeOut(300, MainUI);
  });
  $("#choose-o").on("click", function() {
    playerSymbol = "O";
    enemySymbol = "X";
    $("#ChooseXorO").fadeOut(300, MainUI);


  });//End Symbol Selection
    
  //PlayerMovement  
  var player1turn = true;
  $(".cell").click(function(event) {
    if (player1turn && !$(this).hasClass("blue")) {
      $(this).addClass("red");
      $("#playerone").removeClass("red");
      $("#playertwo").addClass("blue");
      player1turn = false;
      var id =event.target.id;
      var Id=getId(event.target.id);
      var results=Game.methods.MakeMove(1,Id).call({from: web3.eth.defaultAccount,gas:3000000},function(err, value) {
        alert("MakeMove return value= "+value);
      });
      /*var turn =Game.methods.MakeMove(1,Id).call(function(code){
        console.info(code);
        alert(code);
        addToLog(code);
      }).catch(function(error){
        alert(error.message);
      });
      */
      addToLog("Game.methods.MakeMove(1,"+Id+").send({from: web3.eth.defaultAccount,gas:3000000});");

    }else if (!$(this).hasClass("red")){
      $(this).addClass("blue");
      $("#playertwo").removeClass("blue");
      $("#playerone").addClass("red");
      player1turn = true;
      var id =event.target.id;
      var Id=getId(event.target.id);
      var results=Game.methods.MakeMove(2,Id).call({from: web3.eth.defaultAccount,gas:3000000},function(err, value) {
        alert("MakeMove return value= "+value);
      });
      //alert(Promise.resolve(results))
      /*var turn =Game.methods.MakeMove(2,Id).call(function(code"){
        console.info(code);
        alert(code);
        addToLog("Game.methods.MakeMove(2,"+id+").send({from: web3.eth.defaultAccount,gas:3000000});");
      }).catch(function(error){
        alert(error.message);
      });
      */
      addToLog("Game.methods.MakeMove(2,"+Id+").send({from: web3.eth.defaultAccount,gas:3000000});");

    }
  });//End  Player Turn
});
function MainUI() {
  $("#MainUI").fadeIn(300);
}
function getId(id){
  switch(id){
    case "A1":
    return 0;
    break;
    case "A2":
    return 1;
    break;
    case "A3":
    return 2;
    break;
    case "B1":
    return 3;
    break;
    case "B2":
    return 4;
    break;
    case "B3":
    return 5;
    break;
    case "C1":
    return 6;
    break;
    case "C2":
    return 7;
    break;
    case "D3":
    return 8;
    break;
  }
}
})(jQuery);


window.onload = function() {
  document.getElementById("MainUI").style.display = "none";
  document.getElementById("ChooseXorO").style.display = "none";
  
 document.getElementById("overlay").style.display = "block";
};