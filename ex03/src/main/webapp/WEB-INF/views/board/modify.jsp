<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
    .uploadResult {
        width:100%;
        background-color:gray;
    }
    
    .uploadResult ul{
        display:flex;
        flex-flow: row;
        justify-content: center;
        align-items: center;
    }
    
    .uploadResult ul li{
        list-style: none;
        padding: 10px;
        align-content: center;
        text-align: center;
    }
    
    .uploadResult ul li img{
        width: 100px;
    }
    
    .uploadResult ul li span{
        color: white;
    }
    
    .bigPictureWrapper{
        position: absolute;
        display: none;
        justify-content: center;
        align-items: center;
        top: 0%;
        width: 100%;
        height: 100%;
        background-color: gray;
        z-index: 100;
        background: rgba(255, 255, 255, 0.5);
    }
    
    .bigPicture{
        position: relative;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    
    .bigPicture img{
        width: 600px;
    }
</style>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Register</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Register</div>
			<div class="panel-body">
				<form role="form" action="${pageContext.request.contextPath}/board/modify" method="post">

					<div class="form-group">
						<label>Bno</label> <input class="form-control" name="bno"
							value="<c:out value="${board.bno }"/>" readonly="readonly">
					</div>

					<div class="form-group">
						<label>Title</label> <input class="form-control" name="title"
							value="<c:out value="${board.title }"/>">
					</div>

					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name="content"><c:out
								value="${board.content }" /></textarea>
					</div>

					<div class="form-group">
						<label>Writer</label> <input class="form-control" name="writer"
							value="<c:out value="${board.title }"/>" readonly="readonly">
					</div>

					<div class="form-group">
						<label>RegDate</label> <input class="form-control" name="regDate"
							value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/>'
							readonly="readonly">
					</div>

					<div class="form-group">
						<label>Update Date</label> <input class="form-control"
							name="updateDate"
							value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>'
							readonly="readonly">
					</div>

					<button data-oper="modify" class="btn btn-default">Modify</button>
					<button data-oper="remove" class="btn btn-danger">Remove</button>
					<button data-oper="list" class="btn btn-default">List</button>
					
					<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
					<input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
					<input type="hidden" name="type" value="<c:out value="${cri.type}"/>">
					<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
				</form>
			</div>
		</div>
	</div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">Files</div>
            <div class="panel-body">
				<div class="form-group uploadDiv">
					<input type="file" name="uploadFile" multiple>
				</div>
                <div class="uploadResult">
					<ul>
					</ul>
				</div>
			</div>
        </div>
    </div>
</div>
<script>
	$(document).ready(function() {
		var formObj = $("form");
		var bno = "<c:out value='${board.bno}'/>";
		
		var regex =  new RegExp("(.*)\.(exe|sh|zip|alz)$");
   		var maxSize = 5242880; //5MB

    function checkExtension(fileName, fileSize){
        if(fileSize > maxSize){
            alert("파일 사이즈 초과")
            return false;
        }

        if(regex.test(fileName)){
            alert("해당 종류의 파일은 업로드 할 수 없습니다.")
            return false;
        }
        return true;
    }

    function showUploadResult(uploadResultArr){
        if(!uploadResultArr || uploadResultArr.length == 0){return;}

        var uploadUL = $(".uploadResult ul");

        var str = "";

        $(uploadResultArr).each(function(i, obj){
            if(obj.image){
                var fileCallPath = encodeURIComponent(
                    obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
                str += "<li data-path='"+obj.uploadPath+"'"
                            +"data-uuid='"+obj.uuid+"'" 
                            +"data-filename='"+obj.fileName+"'"
                            +"data-type='"+obj.image+"'>"
                        +"<div>"
                            +"<span> "+ obj.fileName+"</span>"
                            +"<button type='button' class='btn btn-waring btn-circle'"
                                    +"data-file='"+fileCallPath+"'"
                                    +"data-type='image'>"
                            +"<i class='fa fa-times'></i>"
                            +"</button><br>"
                            +"<img src='/ex03/display?fileName="+fileCallPath+"'>"
                        +"</div>"
                      +"</li>";
            }else{
                var fileCallPath = encodeURI(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
                var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");

                str += "<li data-path='"+obj.uploadPath+"'"
                            +"data-uuid='"+obj.uuid+"'" 
                            +"data-filename='"+obj.fileName+"'"
                            +"data-type='"+obj.image+"'>"
                        +"<div>"
                            +"<span>"+obj.fileName+"</span>"
                            +"<button type='button' class='btn btn-warning btn-circle'"
                                    +"data-file='"+fileCallPath+"'" 
                                    +"data-type='file'>"
                            +"<i class='fa fa-times'></i>"
                            +"</button><br>"
                            +"<img src='/ex03/resources/img/attach.png'></a>"
                        +"</div>"
                      +"</li>"
            }
        });
        uploadUL.append(str);
    }
	$("input[type='file']").change(function(e){
        var formData = new FormData();

        var inputFile = $("input[name='uploadFile']");

        var files = inputFile[0].files;

        for(var i=0; i<files.length; i++){
            if(!checkExtension(files[i].name, files[i].size)){
                return false;
            }
            formData.append("uploadFile", files[i]);
        }

        $.ajax({
            url: "/ex03/uploadAjaxAction",
            processData: false,
            contentType: false,
            data: formData,
            type: "POST",
            dataType:"json",
            success:function(result){
                //console.log(result);
                showUploadResult(result);
            }
        });
    });		
		$.getJSON("/ex03/board/getAttachList", {bno:bno}, function(arr){

			console.log(arr);

			var str = "";

			$(arr).each(function(i, attach){

				if(attach.fileType){
					var fileCallPath = 
						encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
					
					str += "<li data-path='"+attach.uploadPath+"' "
								+"data-uuid='"+attach.uuid+"' "
								+"data-filename='"+attach.fileName+"' "
								+"data-type='"+attach.fileType+"'>"
								
								+"<span>"+attach.fileName+"</span>"
								
								+"<button type='button'"
										+"data-file='"+fileCallPath+"'"
										+"data-type='image'"
										+"class='btn btn-waring btn-circle'>"
								+"<i class='fa fa-times'></i>"
								+"</button><br>"
								+"<div>"
								+"<img src='/ex03/display?fileName="+fileCallPath+"'>"
								+"</div>"
						+"</li>";
				} else{
					str += "<li data-path='"+attach.uploadPath+"' "
								+"data-uuid='"+attach.uuid+"' "
								+"data-filename='"+attach.fileName+"' "
								+"data-type='"+attach.fileType+"'>"

								+"<span>"+attach.fileName+"</span><br>"
								+"<button type='button'"
										+"data-file='"+fileCallPath+"'"
										+"data-type='file'"
										+"class='btn btn-waring btn-circle'>"
								+"<i class='fa fa-times'></i>"
								+"</button><br>"
								+"<div>"
								+"<img src='/ex03/resources/img/attach.png'>"
								+"</div>"
						+"</li>";
				}
			});

			$(".uploadResult ul").html(str);
		});
		
		$(".uploadResult").on("click", "button", function(e){
			console.log("delete file");
			if(confirm("Remove this file?")){
				var targetLi = $(this).closest("li");
				targetLi.remove();
			}
		});

		$("button").on("click", function(e) {
			e.preventDefault();
			var operation = $(this).data("oper");
			console.log(operation);
			
			if(operation === "remove"){
				formObj.attr("action", "${pageContext.request.contextPath}/board/remove");
			
			}else if(operation==="list"){
			//	self.location="${pageContext.request.contextPath}/board/list";
				formObj.attr("action","${pageContext.request.contextPath}/board/list").attr("method","get");
				var pageNumTag = $("input[name='pageNum']").clone(); 
				var amountTag = $("input[name='amont']").clone();
				var keywordTag = $("input[name='keyword']").clone(); 
				var typeTag=$("input[name='type']").clone();
				
				formObj.empty();
				
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
			}else if(operation=="modify"){
				console.log("submit clicked");

				var str= "";

				$(".uploadResult ul li").each(function(i, obj){
					var jobj = $(obj);
					console.dir(jobj);

					str += "<input type='hidden'"
							+"name='attachList["+i+"].fileName'"
							+"value='"+jobj.data("filename")+"'>";

							+"<input type='hidden'" 
							+"name='attachList["+i+"].uuid'"
							+"value='"+jobj.data("uuid")+"'>";

							"<input type='hidden'" 
							+"name='attachList["+i+"].uploadPath'"
							+"value='"+jobj.data("uploadPath")+"'>";

							"<input type='hidden'"
							+"name='attachList["+i+"].fileType'"
							+"value='"+jobj.data("fileType")+"'>";
				});
				formObj.append(str).submit();
			}
			formObj.submit();
		});
		
		
	});
</script>
<%@ include file="../includes/footer.jsp"%>