<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<head>
<title>大房间管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<jsp:include page="/public/title.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/fileinput.css" media="all"	type="text/css" />
<script src="${pageContext.request.contextPath}/js/fileinput.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/fileinput_locale_zh.js" type="text/javascript"></script>
<script type="text/javascript">
	var path = '${pageContext.request.contextPath}';
</script>
<!-- //tables -->
</head>
<body class="dashboard-page">
	<jsp:include page="/public/menu.jsp" />
	<section class="wrapper scrollable">
		<section class="title-bar">
			<jsp:include page="/public/top.jsp" />
		</section>
		<div class="main-grid">
			<div class="agile-grids">
				<button class="btn btn-default">大房间管理</button>
				<a class="btn btn-default"
					style="float: right;background-color: #87CEFA"
					href="javascript:on_click_open_update_model();">点击添加</a><br/>
				<div class="agile-tables">
					<div class="w3l-table-info">
						<table id="utable" class="table table-hover"></table>
					</div>
				</div>
			</div>
		</div>
		<!-- 删除模态框（Modal） -->
		<div class="modal fade" id="myDel" tabindex="-1" role="dialog"
			aria-labelledby="myDelLabel" aria-hidden="true">
			<div class="modal-dialog" style="width: 18%;">
				<div class="modal-content">
					<div class="modal-header" style="background-color:#FFD700;">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title " id="myModalLabel">
						    <input type="hidden" id="del_id">
							<span class="glyphicon glyphicon-warning-sign"></span> 警告
						</h4>
					</div>
					<div class="modal-body">
						确定要进行操作吗？
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">
							<span class="glyphicon glyphicon-remove"></span>关闭
						</button>
						<button type="button" class="btn btn-primary"
							onclick="on_click_del();">
							<i class="glyphicon glyphicon-ok"></i>确认
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
		<!-- 新增或修改模态框（Modal） -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" style="width: 35%;">
				<div class="modal-content">
					<div class="modal-header" style="background-color: #87CEFA;">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">
							<span class="glyphicon glyphicon-pencil"></span> 新增或修改
							 <input type="hidden" id="t_id">
						</h4>
					</div>
					<div class="modal-body">
						<div style="height: 40px;">
							<label class="col-md-2 control-label">主播ID:</label>
							<div class="col-md-6">
								<div class="input-group">
									<span class="input-group-addon"> <i
										class="glyphicon glyphicon-user"></i>
									</span>
									<input type="text" id="anthorId" 
										class="form-control1" placeholder="请输入主播Id."
										onfocus="on_focus('anthorId', '请输入主播Id.')"
										onblur="on_blur('anthorId')">
								</div>
							</div>
							<div class="col-sm-4" id="anthorId_validate">
								<p class="help-block" style="color: red;">*</p>
							</div>
						</div>
						<br/>
						<div style="height: 40px;">
							<label class="col-md-2 control-label">排序值:</label>
							<div class="col-md-6">
								<div class="input-group">
									<span class="input-group-addon"> <i
										class="glyphicon glyphicon-sort-by-attributes"></i>
									</span>
									<input type="text" id="t_sort" 
										class="form-control1" placeholder="请输入排序值."
										onfocus="on_focus('t_sort', '请输入排序值.')"
										onblur="on_blur('t_sort')">
								</div>
							</div>
							<div class="col-sm-4" id="t_sort_validate">
								<p class="help-block" style="color: red;">*</p>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">
							<span class="glyphicon glyphicon-remove"></span>关闭
						</button>
						<button type="button" class="btn btn-primary"
							onclick="on_click_submit();">
							<span class="glyphicon glyphicon-floppy-disk"></span>提交
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
		<div class="modal fade" id="img_preview" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" style="width: 35%;">
				<div class="modal-content">
					<div class="modal-header" style="background-color: #87CEFA;">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">
						  <span class="glyphicon glyphicon-picture"></span> 预览
						</h4>
					</div>
					<div class="modal-body">
						<div>
							<div class="agile-gallery-grid">
								<div class="agile-gallery">
								   <img id="hand_img" src="${pageContext.request.contextPath }/images/g4.jpg" width="100%" alt="" />
								</div>
							</div>
						</div>
						<br/>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">
							<span class="glyphicon glyphicon-remove"></span>关闭
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
		<jsp:include page="/public/lower.jsp" />
	</section>
	<script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/bootstrap-table/bootstrap-table.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/bootstrap-table/bootstrap-table-zh-CN.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/javascript/big_man_list.js"></script>

</body>
</html>
