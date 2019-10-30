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
      $("#branchDelete").click(function(){
          callAjax(94);
      });
    });
    function callAjax(idx){
        $.ajax({
           type: "DELETE",
           url : "http://localhost:8181/admin/branchmanage/delete/"+idx,
           data: {},
           success: whenSuccess,
        });
    }
    function whenSuccess(){
          window.location.href = "/admin/branchmanage/";
      }

</script>

<!DOCTYPE html>
<html>
<head>

<title>Document</title>
</head>
<body>
   <h1>Branch</h1>

   <button data-target="#layerpop" data-toggle="modal">지점추가</button>
   <br />
   <div class="modal fade" id="layerpop">
      <div class="modal-dialog">
         <div class="modal-content">
            <!-- header -->
            <div class="modal-header">
               <h4 class="modal-title">지점 추가</h4>
               <!-- 닫기(x) 버튼 -->
               <button type="button" class="close" data-dismiss="modal">×</button>
               <!-- header title -->

            </div>
            <!-- body -->
            <div class="modal-body">
               <form action="http://localhost:8181/admin/branchmanage"
                  method="post">
                  <p>
                     <strong>지점명</strong> <input type="text" name="branchName">
                  </p>
                  <p>
                     <strong>지점장</strong> <input type="text" name="branchOwner">
                  </p>
                  <p>
                     <strong>운반비</strong> <input type="text" name="branchValue">
                  </p>
                  
                  <p>
                  <strong>주소</strong>
                  <input type="text" id="sample6_address" name="branchAddr" placeholder="주소" readonly>
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
                  <input type="submit" id="branchInsert" value="추가">
                  <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>

               </form>
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
   <table border="1">
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
   </table>
   
</body>
</html>