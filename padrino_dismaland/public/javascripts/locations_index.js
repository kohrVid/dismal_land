var curLoc = 19;

var authenticityToken;
/*This here is the observer pattern. When the event occurs, the code should run.*/
window.onload = function() {
  //csrf token below:
  authenticityToken = $("input[name=authenticity_token]").attr("value");
  showLocation(curLoc);
  $("#commentSubmitForm").click(function () {
    $.post("/comments", 
	{
	  "comment[author]": $("#commentAuthor").val(),
	  "comment[body]": $("#commentBody").val(),
	  "comment[location_id]": $("#commentLocationId").val(),
	  authenticity_token: authenticityToken
	},
	//The response function is a callback
	function (response) {
	  response = JSON.parse(response);
	  $("#commentsIndex").prepend(buildComment(response));
	}
    );
    console.log("2");
    //console log 2 is sent first because it's asynchronous and keeps chugging along even whilst the earlier function is being carried out.
  });
};
function showLocation(locNum) {
  var loc = locations[locNum - 1];
  $("#locName").html(loc.name);
  $("#commentLocationId").attr("value", locNum);
  $("#locDesc").html(loc.description);
  $("#locPic").attr("src", "/images/" + loc.name.toLowerCase().replace(/ /g, "_") + ".gif");

  //Direction Links
  var myDiv = $("#directionLinks");
  //Clear out everything
  myDiv.empty();
  
  for(var i = 0; i < loc.directions.length; i++){
    var direction = loc.directions[i];
  // Build a new button
    var myButton = $("<input>").attr("type", "button").attr("class", "button");
    //var myButton = $("document").add("input");

    myButton.attr("value", direction.direction + " --> " + locations[direction.destination_id - 1].name);
    //Building a function for each button --> A closure
    myButton.on("click",
      function(cool_id) {
      //stash the value of direction at the time so that different buttons have different links. The inner function is the event handler.
      return function () {
	showLocation(cool_id);
      };
    } (direction.destination_id)
    //The line above passes the destination_id to the anon function each time the button's click.
  );
  myDiv.append(myButton);
  myDiv.append($("<br>"));
  }
  var commentDiv = $("#commentsIndex");
  commentDiv.empty();
  for(var i = 0; i < loc.comments.length; i++){
    var comment = loc.comments[i];
    commentDiv.append(buildComment(comment));
  }
}
var buildComment = function(comment) { 
  return "<div class='commentText'><strong>" + comment.author + 
      "</strong> says:</div><div class='commentBody'>" + comment.body + "</div><small><div><strong>Posted at</strong> " + 
      comment.created_at + "</div><div><strong>Last updated at</strong> " + comment.updated_at + "</div></small>";
}
