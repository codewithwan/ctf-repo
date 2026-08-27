import{d as s,a as o}from"../chunks/disclose-version.DvAHpqpx.js";import"../chunks/legacy.mCRvWJeC.js";var i=s(`<div class="h-80 flex justify-center items-end home_div"><script src="https://kit.fontawesome.com/8ac6ea753d.js" crossorigin="anonymous"><\/script> <div id="outside-smth-div" hidden>...what? you thought the outside was real?</div> <div id="outside-no-div" hidden>yes</div> <script>
  var response = prompt("you there! are you a BushBashCTF competitor?")
  if (response != null) {
    response = response.toLowerCase();
    if (response == "yes") {
      alert("hey... you don't seem to be browsing the web very ethically right now :<");
      document.getElementById("outside-smth-div").style.display = "block";
    }
    else if (response == "no") {
      alert("...alright, sure. go ahead then :>");
      document.getElementById("outside-no-div").style.display = "block";
    }
    else {
      alert("...")
      document.getElementById("outside-smth-div").style.display = "block";
    }
  } else {
    alert("hey, dont ignore me now :(")
    document.getElementById("outside-smth-div").style.display = "block";
  }
<\/script></div>`);function n(e){var t=i();o(e,t)}export{n as component};
