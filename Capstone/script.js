function findlocation()
  {
    const url = "http://capstone5.dothome.co.kr/getData.php";
    fetch(url)
      .then(res => res.json())
      .then(res => {
        // console.log(res)
        imgCheck(res);
        imgCheck(res);
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
function imgCheck(res)
  {
    var mark = document.getElementById("x");
  if (res !== [])
      {
       //정보가 있으면 거기에 마커 출력
       mark.innerHTML = '<img src="images/marker.PNG"/>'
      }
      else
      {
         //공백일땐 출력 x
        mark.innerHTML = '';  
      }

}


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