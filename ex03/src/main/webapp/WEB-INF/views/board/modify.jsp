<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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

<script>
	$(document).ready(function() {
		var formObj = $("form");
		
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
			}
			formObj.submit();
		});
		
		
	});
</script>
<%@ include file="../includes/footer.jsp"%>