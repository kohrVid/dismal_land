var curLoc = 19;

var authenticityToken;
var currentlyEditing = null;
window.onload = function() {
  //csrf token below:
  authenticityToken = $("input[name=authenticity_token]").attr("value");
  //Show the first location
  showLocation(curLoc);
   //================Create==============================
  $("#commentSubmitForm").click(function () {
    $.post("/comments", 
	{
	  "comment[author]": $("#commentAuthor").val(),
	  "comment[body]": $("#commentBody").val(),
	  "comment[location_id]": curLoc,//$("#commentLocationId").val(),
	  authenticity_token: authenticityToken
	},
	//The response function is a callback
	function (response) {
	  if (typeof (response) == "string"){
	    response = JSON.parse(response);
	  }
	  locations[curLoc - 1].comments.unshift(response);
	  $("#commentsIndex").prepend(buildComment(response));
	}
      );
  });
};
function showLocation(locNum) {

  //========================Navigation button================================
  var loc = locations[locNum - 1];
  $("#locName").html(loc.name);
  $("#commentLocationId").attr("value", locNum);
  $("#locDesc").html(loc.description);
  $("#locPic").attr("src", "/images/" + loc.name.toLowerCase().replace(/ /g, "_") + ".gif");

  var myDiv = $("#directionLinks");
  myDiv.empty();
  
  for(var i = 0; i < loc.directions.length; i++){
    var direction = loc.directions[i];
    var myButton = $("<input>").attr("type", "button").attr("class", "button");

    myButton.attr("value", direction.direction + " --> " + locations[direction.destination_id - 1].name);
    myButton.on("click",
      function(cool_id) {
     return function () {
	showLocation(cool_id);
      };
    } (direction.destination_id)
  );
  myDiv.append(myButton);
  myDiv.append($("<br>"));
  }
  curLoc = locNum;
  var commentDiv = $("#commentsIndex");
  commentDiv.empty();
  for(var i = 0; i < loc.comments.length; i++){
    var comment = loc.comments[i];
    commentDiv.append(buildComment(comment));
  }

//==================Tag Cloud===================
//  var tags = loc.tags;
  console.log(tags);
  for (var i in tags) {
    var tag_size = (tags[i].locations.length/1.5) + "rem";
    var tag_link = $('<span><a style="font-size:'+tag_size+';" href="/tags/' + tags[i].id + '">' + tags[i].name + '</a></span>');
    $("#tagcloud").prepend(tag_link);
    console.log(tag_link);
  } 
}

//========================List Comments in Divs======
var buildComment = function(comment) { 
  var created_date = new Date(comment.created_at).toDateString().split(" ");
  var updated_date = new Date(comment.updated_at).toDateString().split(" ");
  var created_time = new Date(comment.created_at).toTimeString().split(" ");
  var updated_time = new Date(comment.updated_at).toTimeString().split(" ");
  var newComment = $('<div data-id="' + comment.id + '" class="commentText"></div>');
  newComment.append('<div class="commentAuthor"><strong>' + comment.author + 
      '</strong> says:</div><div class="commentBody">' + comment.body +
      '</div><small><div><strong>Posted at</strong> ' + 
      created_time[0] + " on " + created_date[2] + " " + created_date[1] +
      " " + created_date[3] + "</div><div><strong>Last updated at</strong> " +
      updated_time[0] + " on " + updated_date[2] + " " + updated_date[1] + " " +
      updated_date[3]  + "</div></small>");
  //=============================Updating======================
  newComment.find(".commentBody").on("click", function() {
    currentlyEditing = $(this);
    var newBody = $('<textarea id="editBody">' + currentlyEditing.html() + '</textarea>');
    currentlyEditing.replaceWith(newBody);
    newBody.on("keypress", function () {
      if (event.keyCode === 13){
	$.post("/comments/" + parseInt(newComment.attr("data-id")),
	  {"comment[body]": newBody.val(),
	   _method: "put", authenticity_token: authenticityToken },
	  function (response) {
	    var myLoc = locations[curLoc - 1];
	    $("#commentsIndex").find(newComment).replaceWith(buildComment(response));
	  });
	 console.log("Submit");
       }
     });
  });
  //======================= Destroy Comments ===========================
  var destroyButton = $('<input type="button" class="button" value="DESTROY">');
  destroyButton.click( function () {
    $.post("/comments/" + comment.id,
      { _method: "delete", authenticity_token: authenticityToken },
      function (response) {
	var myLoc = locations[curLoc - 1];
	myLoc.comments = myLoc.comments.filter(  function(c){
	  return c.id != response.id;
	});
	$("#commentsIndex").find(newComment).replaceWith(myLoc.comments);
      });
      console.log("I destroyed it!!!");
    });
    newComment.append(destroyButton);
    return newComment;


}



