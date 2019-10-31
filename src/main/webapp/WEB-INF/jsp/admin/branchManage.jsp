<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
                document.getElementById("sample6_address").value = addr;
                document.getElementById("sample6_detailAddress").focus();
             
            }
        }).open();
    }
</script>


  <script type="text/javascript">
  
  
  $(document).ready(function(){
	    branchlist();
	    $('[name=branchInsertBtn]').click(function(){
	  	  console.log("@@@@@@@@@@@@@@")
	  	 // var insertData = $('[name=branchInsertform]').serialize();
	  	  	var b = $('[name=branchInsertform]');
	  	  var formData = $('[name=branchInsertform]').serializeObject()
			console.log(formData)
		//	console.log(JSON.stringify(formData))
		//	console.log(formData)
	  	/* let a = fn_formParse();
	  	console.log(a);
	  	console.log(a);
	  	branchinsert(a); */
	  	console.log(JSON.stringify(formData));
			branchinsert(JSON.stringify(formData));
	    })
	});
  
//form json 변환1
$.fn.serializeObject = function() {

  var result = {}
  var extend = function(i, element) {
    var node = result[element.name]
    if ("undefined" !== typeof node && node !== null) {
      if ($.isArray(node)) {
        node.push(element.value)
      } else {
        result[element.name] = [node, element.value]
      }
    } else {
      result[element.name] = element.value
    }
  }

  $.each(this.serializeArray(), extend)
  return result
}
  
  //insert
	function branchinsert(insertData){
		console.log("branchinsert In@@@@@@@@")
		$.ajax({
		     type  : "POST",
			 url : "http://localhost:8181/admin/branchmanage",
			 data   : insertData,
			 contentType: 'application/json',
			 success : function(data){
				 branchlist();
			 }
		})
	}
  
  
    function branchdelete(idx){
        $.ajax({
           type: "DELETE",
           url : "http://localhost:8181/admin/branchmanage/delete/"+idx,
           data: {},
           success: function(data){
        	   branchlist();
           }
        });
    }
 
	
    function branchlist() {
    		$.ajax({
    			url:"http://localhost:8181/admin/branchmanage.do",
    			data: {},
    			success:function(data){
    				console.log(data);
    			      var str = '<tr>'+
    				  '<th>번호</th>'+
                      '<th>지점명</th>'+
                      '<th>지점장</th>'+
                      '<th>운반비</th>'+
                      '<th>주소</th>'+
                      '<th>전화번호</th>'+
                      '<th>수정/삭제</th>'+
                      '</tr>';
                      
                          $.each(data, function(i, s) {
                              str +=    '<tr>' +
                              '<td>' + data[i].branchIndex + '</td>'+
                              '<td>' + data[i].branchName + '</td>'+
                              '<td>' + data[i].branchOwner + '</td>'+
                              '<td>' + data[i].branchValue + '</td>'+
                              '<td>' + data[i].branchAddr + '</td>'+
                              '<td>' + data[i].branchPhone + '</td>'+
                              '<td><button>수정</button><button onclick="branchdelete('+ data[i].branchIndex + ')">삭제</button></td>'
                              +'</tr>';
                          });
                      $("#tableTest").html(str);
                  }
    		})
    }

    

</script>

<!DOCTYPE html>
<html>
<head>

<title>Document</title>
</head>
<body>
   <h1>Branch</h1>

	<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
	지점 추가
	</button>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
      <h4 class="modal-title" id="myModalLabel">지점 추가</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
		 <form name="branchInsertform">
                  <p>
                     <strong>지점명</strong> <input type="text" name="branchName">
                  </p>
                  <p>
                     <strong>지점장</strong> <input type="text" name="branchOwner">
                  </p>
                  <p>
                     <strong>운반비</strong> <input type="number" name="branchValue">
                  </p>
                  
                  <p>
                  <strong>주소</strong>
                  <input type="text" id="sample6_address" name="branchAddr" placeholder="주소">
                  <input type="button" onclick="sample6_execDaumPostcode()" value="주소 찾기"><br>
                  <strong>상세주소</strong>
                  <input type="text" id="sample6_detailAddress" name="branchDaddr" placeholder="상세주소"></p>
                  
                  <p>
                     <strong>전화번호</strong> <input type="text" name="branchPhone">
                  </p>

                  <p>
                     <strong>지역</strong> <select name="areaIndex">
                        <option value=1>경기도</option>
                        <option value=2>강원도</option>
                        <option value=3>충청남도</option>
                        <option value=4>충청북도</option>
                        <option value=5>경상북도</option>
                        <option value=6>경상남도</option>
                        <option value=7>전라남도</option>
                        <option value=8>전라북도</option>
                     </select>
                  </p>

                  <p hidden>
                     <strong>위도</strong> <input type="text" name="branchLat">
                  </p>
                  <p hidden>
                     <strong>경도</strong> <input type="text" name="branchLng">
                  </p>  
                  </form>    
                  </div>
                  
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" name="branchInsertBtn" class="btn btn-primary">Save</button>
      </div>
    </div>
  </div>
</div>

  

 <br />
   <div class="modal fade" id="layerpop1">
      <div class="modal-dialog">
         <div class="modal-content">
            <!-- header -->
            <div class="modal-header">
               <h4 class="modal-title">지점 수정</h4>
               <!-- 닫기(x) 버튼 -->
               <button type="button" class="close" data-dismiss="modal">×</button>
               <!-- header title -->

            </div>
            <!-- body -->
            <div class="modal-body">
               <form action="http://localhost:8181/admin/branchmanage"
                  method="post">
                  
                  <p>
                     <strong>지역</strong> <input type="text" name="branchArea" value="${initpage[0].area.areaName}" readonly>
                  </p>
                  <p>
                     <strong>지점명</strong> <input type="text" name="branchName" value="${initpage[0].branchName}" readonly>
                  </p>
                  <p>
                     <strong>지점장</strong> <input type="text" name="branchOwner" value="${initpage[0].branchOwner}">
                  </p>
                  <p>
                     <strong>운반비</strong> <input type="text" name="branchValue" value="${initpage[0].branchValue}">
                  </p>
                  <p>
                     <strong>전화번호</strong> <input type="text" name="branchPhone" value="${initpage[0].branchPhone}">
                  </p>


                  <p hidden>
                     <strong>위도</strong> <input type="text" name="branchLat">
                  </p>
                  <p hidden>
                     <strong>경도</strong> <input type="text" name="branchLng">
                  </p>
                  <input type="button" id="branchInsert" value="추가">
                  <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>

               </form>
            </div>
         </div>
      </div>
   </div>

   <br />
  <%--  <table border="1">
      <th>번호</th>
      <th>지점명</th>
      <th>지점장</th>
      <th>운반비</th>
      <th>주소</th>
      <th>전화번호</th>
      <th>수정/삭제</th>

      <c:forEach items="${initpage}" var="list">
         <tr>
            <td>${list.branchIndex}</td>
            <td>${list.branchName}</td>
            <td>${list.branchOwner}</td>
            <td>${list.branchValue}</td>
            <td>${list.branchAddr}</td>
            <td>${list.branchPhone}</td>
            <td>
               <button data-target="#layerpop1" data-toggle="modal">수정</button>
               <button id="branchDelete">삭제</button>
            </td>
         </tr>
      </c:forEach>
   </table> --%>
   
   <div id="Testliset"></div>
   <table id ="tableTest">
   </table>
   <div id ="test123"></div>
   
   
   
</body>


</html>