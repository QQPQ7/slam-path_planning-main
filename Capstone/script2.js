function findlocation()
  {
    const url = "http://capstone5.dothome.co.kr/getData.php";
    fetch(url)
      .then(res => res.json())
      .then(res => {
        // console.log(res)
        imgCheck(res);
        markCheck(res);
      });
  }

// function display_image(src, width, height, alt, res) {
//   var a = document.createElement("mark");
//   a.src = src;
//   a.width = width;
//   a.height = height;
//   a.alt = alt;
//   document.body.appendChild(a);
//   
function markCheck(res)
  {
    var mark = document.getElementById("mark");
    var x = document.getElementById("x");
    var y = document.getElementById("y");
  if (res !== [])
      {
       x = res[0]; //x y 가지고 좌표 위치 계산하는 방법 생각하기 8,10 인가 그건 310 600 임
       y = res[1];
       //console.log(x);
       //정보가 있으면 거기에 마커 출력
       mark.innerHTML = '<img src="images/marker.png"/>' 
      }
      else
      {
         //공백일땐 출력 x
        mark.innerHTML = '';  
      }

}
function writedata()
  {
    const url = "http://capstone5.dothome.co.kr/changeData.php";
    fetch(url)
      .then(res => res.json())
      .then(res => {
        // console.log(res)
        imgCheck(res);
        markCheck(res);
      });
  }

function loadFile(filePath) {
  var result = null;
  var xmlhttp = new XMLHttpRequest();
  xmlhttp.open("GET", filePath, false);
  xmlhttp.send();
  if (xmlhttp.status==200) {
    result = xmlhttp.responseText;
  }
  console.log(result);
  return result;
}
//출처: https://goodsgoods.tistory.com/364 [행복의 나라:티스토리]



function imgCheck(res)
  {
    console.log(res);
    
    // img file id 생성
    var img = document.getElementById("img");

    // img file 존재 여부 체크
    if (res !== [])
    {
      img.innerHTML = '<img src="images/img.PNG"/>';
    }
      
    else
    {
      img.innerHTML = '';  
    }
  }

setInterval(findlocation, 1000);