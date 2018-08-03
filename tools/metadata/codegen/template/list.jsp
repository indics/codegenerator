<#import "function.ftl" as func>
<#assign class=model.variables.class>
<#assign comment=model.tabComment>
<#assign class=model.variables.class>
<#assign comment=model.tabComment>
<#assign classVar=model.variables.class?lower_case>
<#assign classVar=model.variables.classVar>
<#assign commonList=model.commonList>
<#assign pkModel=model.pkModel>
<#assign pk=func.getPk(model) >
<#assign pkVar=func.convertUnderLine(pk) >
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>${comment }管理</title>
<%@include file="/commons/include/get-hplus.jsp" %>
<script type="text/javascript">
	$(function() {
		//添加		
		jQuery(".btn-add").click(function(){
			location.href= 'edit.ht';	
		});
		
		//编辑
		jQuery(".btn-edit").click(function(){
			var $ids = jQuery("#table_list_${classVar}").jqGrid('getGridParam', 'selarrrow'); 
			if ($ids.length == 0) {
				swal({
					title:"警告信息",
					type: "warning",
					text:"请选择要编辑的行"					
				});
			}else if($ids.length > 1){
				swal({
					title:"警告信息",
					type: "warning",
					text:"只能选择一条记录"					
				});
			}else{
				location.href = 'edit.ht?${pkVar}=' + $ids;
			}
		});
		
		//删除
		jQuery(".btn-del").click(
			function() { 
				var $ids = jQuery("#table_list_${classVar}").jqGrid('getGridParam', 'selarrrow'); 
				if ($ids.length > 0) {
					var delId = "";//主键值
					var url = "del.ht?${pkVar}=" + $ids;
					swal({
				        title: "确认删除吗？",
				        text: "删除后将无法恢复，请谨慎操作！",
				        type: "warning",
				        showCancelButton: true,
				        confirmButtonColor: "#DD6B55",
				        confirmButtonText: "删除",
				        cancelButtonText: "取消",
				        closeOnConfirm: true
				    }, function () {
				    	$.ajax({
				    		url : url,
				    		type : 'post',
				    		success : function(res){
				    			var result = eval('('+res+')');
				    			swal(result.message, "您已经永久删除了这条信息。", "success");
				    			jQuery("#table_list_${classVar}").trigger("reloadGrid");
				    		},
							error : function(res) {
								swal(result.message, "服务器或网络出现异常。", "failure");
							}
				    	})	    	       
				    });
				}else{ 
					swal({
						title:"警告信息",
						type: "warning",
						text:"请选择要删除的行"					
					});
				} 
		});
		
		//查询
		jQuery(".btn-search").click(function(){
			var postData = $('#table_list_${classVar}').jqGrid("getGridParam", "postData");
			var frm = $('#searchForm');
			var data = {};
			frm.find('input:text,input:hidden,textarea,select').each(function(){
				var value=$(this).val();
				var name=$(this).attr('name');
				if(value!=null&&value!=''){
					data[name]=value;
				}else{
					if(postData!=null)
						delete postData[name];
				}
			});
            
			$("#table_list_${classVar}").jqGrid('setGridParam',{
				postData : data
			}).trigger("reloadGrid");
			
		});
	});
</script>

<#if model.variables.flowFlag?exists && model.variables.flowFlag=='true'>
<script type="text/javascript">
	$(function() {
		$("a.apply").click(function() {
			$.ajax({
				type : "POST",
				url : 'apply.ht?${pkVar}='+$('#userVacateId').val(),
				success : function(res) {
					var result = eval('('+res+')');
					$.ligerMessageBox.success('提示信息',result.message);
					window.location.href = "list.ht";
				},
				error : function(res) {
					$.ligerMessageBox.error('提示信息',result.message);
				}
			});
		});
	});
</script>
</#if>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content  animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox">
                    <div class="ibox-title">
                        <h5>${comment}管理列表</h5>
                    </div>
                    <div class="ibox-content" for="table_list_course">
                        <p>
                            <button type="button" class="btn btn-success btn-search"><i class="fa fa-search"></i>查询</button>
                            <button type="button" class="btn btn-primary btn-add"><i class="fa fa-upload"></i>添加</button>
                            <button type="button" class="btn btn-info btn-edit"><i class="fa fa-paste"></i>编辑</button>
                            <button type="button" class="btn btn-warning btn-del"><i class="fa fa-warning"></i>删除</button>
                        </p>
                        
                        <div class="ibox float-e-margins">
							<form id="searchForm" class="form-inline" method="post">
								<div class="ibox-content">
									<div class="form-group">
										<#list commonList as col>
										<#assign colName=func.convertUnderLine(col.columnName)>
										<#if (col.colType=="java.util.Date")>
										<label class="control-label">${col.comment} 从:</label> <input id="s_begin${colName}" name="Q_begin${colName}_${func.getDataType("Date","1")}" class="form-control layer-date" placeholder="YYYY-MM-DD"/>
										<label class="control-label">至: </label><input id="s_end${colName}" name="Q_end${colName}_${func.getDataType("Date","0")}" class="form-control layer-date" placeholder="YYYY-MM-DD"/>
										<#else>
										<label class="control-label" for="s_${col.columnName}">${col.comment}:</label><input id="s_${col.columnName}" type="text" name="Q_${colName}_${func.getDataType("${col.colType}","0")}"  class="form-control" />
										</#if>
										</#list>
								</div>
							</form>
						</div>
						
						<div class="jqGrid_wrapper">
                            <table id="table_list_${classVar}" class="jqGrid_table_list"></table>
                            <div id="pager_list_${classVar}"></div>
                       	</div>
                	</div><!-- end of content -->
                </div><!-- end of ibox -->
            </div><!-- end of col -->
        </div><!-- end of row -->
    </div><!-- end of wrapper -->
		
	<script>
        $(document).ready(function(){
        	<#list commonList as col>
			<#assign colName=func.convertUnderLine(col.columnName)>
			<#if (col.colType=="java.util.Date")>
			laydate({elem:"#s_begin${colName}",event:"focus"});
			laydate({elem:"#s_end${colName}",event:"focus"});
			</#if>
			</#list>
			
        	$.jgrid.defaults.styleUI="Bootstrap";
        	
        	$("#table_list_${classVar}").jqGrid({
     				url : 'listData.ht',
     				datatype : "json",
     				height:'100%',
     				autowidth:true,
     				shrinkToFit:true,
     				multiselect:true,
     				rownumbers:true,
     				rowNum:20,
     				rowList:[10,20,30],
     				colNames:["${pkVar}",<#list commonList as col><#if col_has_next>"${col.comment}",<#else>"${col.comment}"</#if></#list>],
     				colModel:[
     				          {name:"${pkVar}",index:"${pkVar}",key:true,hidden:true,width:0},
							<#list commonList as col>
     						<#assign colName=func.convertUnderLine(col.columnName)>
							<#if col_has_next>
							<#if (col.colType=="java.util.Date")>
{name:"${colName}",index:"${colName}",
								formatter:function(value,options,row){
									return new Date(value).Format('yyyy-MM-dd');}},
							<#else>
{name:"${colName}",index:"${colName}"},
							</#if>
							<#else>
							<#if (col.colType=="java.util.Date")>
{name:"${colName}",index:"${colName}",
								formatter:function(value,options,row){
	   				        		 return new Date(value).Format('yyyy-MM-dd');}},
							<#else>
{name:"${colName}",index:"${colName}"}
							</#if>
							</#if>
							</#list>],
     				pager:"#pager_list_${classVar}",
     				viewrecords:true,
     				caption:"${comment}列表",
     				hidegrid:false});
        	
        	$("#table_list_${classVar}").jqGrid("navGrid","#pager_list_${classVar}",
        			{edit:false,add:false,del:false,search:false},
        			{height:200,reloadAfterSubmit:true});
        	
        	$(window).bind("resize",function(){
        			var width=$(".jqGrid_wrapper").width();
        			$("#table_list_${classVar}").setGridWidth(width);
        		})
        	});
    </script>
</body>
</html>


