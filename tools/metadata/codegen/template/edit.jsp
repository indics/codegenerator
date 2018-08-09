<#import "function.ftl" as func>
<#assign class=model.variables.class>
<#assign tabcomment=model.tabComment>
<#assign classVar=model.variables.classVar>
<#assign system=vars.system>
<#assign package=model.variables.package>
<#assign commonList=model.commonList>
<#assign pk=func.getPk(model) >
<#assign path=model.variables.path>
<#assign pkVar=func.convertUnderLine(pk) >
<#assign subtables=model.subTableList>
<%--
	time:${date?string("yyyy-MM-dd HH:mm:ss")}
	desc:edit the ${tabcomment}
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 ${tabcomment}</title>
	<%@include file="/commons/include/form-hplus.jsp" %>
	<script type="text/javascript">
		$(function() {
			var options={};
			if(showResponse){
				options.success=showResponse;
			}
			var frm=<#noparse>$('#</#noparse>${classVar}Form').form();
			$("button.btn-save").click(function() {
				frm.setData();
				frm.ajaxForm(options);
				if(frm.valid()){
					swal("正在保存。。。","请稍等。。。");
					form.submit();
				}
			});

			<#if model.variables.flowFlag?exists && model.variables.flowFlag=='true'>
			$("a.apply").click(function() {
				frm.setData();
				<#noparse>$('#</#noparse>${classVar}Form').attr('action','apply.ht');
				frm.ajaxForm(options);
				if(frm.valid()){
					form.submit();
				}
			});
			
			$("a.agree").click(function() {
				operatorType=1;
				var tmp = '1';
				/*if(isDirectComlete){//直接一票通过
					tmp = '5';
				}*/
				$('#voteAgree').val(tmp);
				$('#back').val("1");

				<#noparse>$('#</#noparse>${classVar}Form').attr("action","complete.ht");
				frm.setData();
				frm.ajaxForm(options);
				if(frm.valid()){
					form.submit();
				}
			});
			
			$("a.notAgree").click(function() {
				
				operatorType=2;
				var tmp = '2';
				/*if(isDirectComlete){//直接一票通过
					tmp = '6';
				}*/
				$('#voteAgree').val(tmp);
				$('#back').val("1");
				
				<#noparse>$('#</#noparse>${classVar}Form').attr("action","complete.ht");
				frm.setData();
				frm.ajaxForm(options);
				if(frm.valid()){
					form.submit();
				}
			});
			</#if>
			
			<#list commonList as col>
			<#assign colName=func.convertUnderLine(col.columnName)>
			<#if (col.colType=="java.util.Date")>
			laydate({elem:"#${colName}",event:"focus"});
			</#if>
			</#list>
		});
		
		function showResponse(responseText) {
			var obj = new com.cosim.form.ResultMessage(responseText);
			if (obj.isSuccess()) {
				swal({
					title:"保存成功！",
					text:"您已经成功保存了这条信息。",
					type:"success"},
					function(){
						setTimeout(function(){
							window.location.href = "<#noparse>${</noparse>ctx}/${system}/${path}/${classVar}/list.ht";		
						},100);
					});
			} else {
				swal("保存失败！","服务器或网络异常。","error");
			}
		}		
	</script>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content  animated fadeInRight">
	<div class="row">
		<div class="col-sm-12">
		<div class="ibox">
             <div class="ibox-title">
               	<c:choose>
				    <c:when test="${classVar}.${pkVar} != null}">
				        <h5>编辑${tabcomment}</h5>
				    </c:when>
				    <c:otherwise>
				        <h5>添加${tabcomment}</h5>
				    </c:otherwise>			   
			    </c:choose>
             </div>
		    
		    <div class="ibox-content" for="table_list_course">
                <p>
                    <button type="button" class="btn btn-primary btn-save"><i class="fa fa-save"></i>保存</button>
                    <button type="button" class="btn btn-info btn-back" onClick="location.href='list.ht'"><i class="fa fa-back"></i>返回</button>
                </p>
                
                <div class="ibox float-e-margins">
					<form id="${classVar}Form" class="form-horizontal m-t" method="post" action="save.ht">
						<table cellpadding="0" cellspacing="0" border="0" type="main">
							<#list commonList as col>
							<#assign colName=func.convertUnderLine(col.columnName)>
							<#if (col.colType=="java.util.Date") >
							<tr>
								<th>${col.comment}: <#if (col.isNotNull) > <span class="required">*</span></#if></th>
								<td><input type="text" id="${colName}" name="${colName}" value="<fmt:formatDate value='<#noparse>${</#noparse>${classVar}.${colName}}' pattern='yyyy-MM-dd'/>" class="form-control date" validate="{date:true<#if col.isNotNull>,required:true</#if>}" validateName='${col.comment}'/></td>
							</tr>
							<#else>
							<tr>
								<th>${col.comment}: <#if (col.isNotNull) > <span class="required">*</span></#if></th>
								<td><input type="text" id="${colName}" name="${colName}" value="<#noparse>${</#noparse>${classVar}.${colName}}"  class="form-control" validate="{<#if col.isNotNull>required:true<#else>required:false</#if><#if col.colType=='String'&& col.length<1000>,maxlength:${col.length}</#if><#if col.colType=='Integer'|| col.colType=='Long'||col.colType=='Float'>,number:true </#if>}"  validateName='${col.comment}'/></td>
							</tr>
							</#if>
							</#list>
						</table>
						<#if subtables?exists && subtables?size != 0>
						<#list subtables as table>
						<#assign foreignKey=func.convertUnderLine(table.foreignKey) >
						<table class="table-grid table-list" cellpadding="1" cellspacing="1" id="${table.variables.classVar}" formType="page" type="sub">
							<tr>
								<td colspan="${table.columnList?size-1}">
									<div class="group" align="left">
							   			<a id="btnAdd" class="link add">添加</a>
						    		</div>
						    		<div align="center">
									${table.tableName } : ${table.tabComment }
						    		</div>
					    		</td>
							</tr>
							<tr>
								<#list table.columnList as col>
								<#assign colName=func.convertUnderLine(col.columnName?lower_case)>
								<#if !(col.isPK)&& colName?lower_case!=(foreignKey)?lower_case>							                              
								<th>${col.comment}</th>
								</#if>									
								</#list>
								<th>操作</th>
							</tr>
							<c:forEach items="<#noparse>${</#noparse>${table.variables.classVar}List}" var="${table.variables.classVar}Item" varStatus="status">
							    <tr type="subdata">
							        <#list table.columnList as col>												
								    <#assign colName=func.convertUnderLine(col.columnName)>
								    <#if ( !col.isPK && colName?lower_case!=foreignKey?lower_case)>
								    <#if (col.colType=="java.util.Date")>
									<td style="text-align: center" name="${colName}"><fmt:formatDate value='<#noparse>${</#noparse>${table.variables.classVar}Item.${colName}}' pattern='yyyy-MM-dd'/></td>								
								    <#else >
								    <td style="text-align: center" name="${colName}"><#noparse>${</#noparse>${table.variables.classVar}Item.${colName}}</td>
								    </#if>
								  	</#if>
								    </#list>
								    <td style="text-align: center">
								    	<a href="#" class="link del">删除</a>
								    </td>
								     <#list table.columnList as col>												
								    <#assign colName=func.convertUnderLine(col.columnName)>
								    <#if ( !col.isPK && colName?lower_case!=foreignKey?lower_case)>
								    <#if (col.colType=="java.util.Date")>
								    <input type="hidden" name="${colName}" value="<fmt:formatDate value='<#noparse>${</#noparse>${table.variables.classVar}Item.${colName}}' pattern='yyyy-MM-dd'/>" class="inputText date"/>
								    <#else >
									<input type="hidden" name="${colName}" value="<#noparse>${</#noparse>${table.variables.classVar}Item.${colName}}"/>
								    </#if>
								  	</#if>
								    </#list>
							    </tr>
							</c:forEach>
							<tr type="append">
					        <#list table.columnList as col>												
						    <#assign colName=func.convertUnderLine(col.columnName)>
						    <#assign foreignKey=func.convertUnderLine(table.foreignKey) >
					   		<#if ( !col.isPK && colName?lower_case!=foreignKey?lower_case)>
					    	<#if (col.colType=="java.util.Date")>
								<td style="text-align: center" name="${colName}"></td>								
						    <#else >
						    	<td style="text-align: center" name="${colName}"><input class="form-control" type="text" name="${colName}" validate="{<#if col.isNotNull>required:true<#else>required:false</#if><#if col.colType=='String'&& col.length<1000>,maxlength:${col.length}</#if><#if col.colType=='Integer'|| col.colType=='Long'||col.colType=='Float'>,number:true </#if>}" validateName='${col.comment}'></td>
						    </#if>
						  	</#if>
						    </#list>
						    	<td style="text-align: center">
						    		<a href="#" class="link del">删除</a>
						    	</td>
					 		</tr>
					    </table>
						</#list>
						</#if>
						<input type="hidden" name="${pkVar}" value="<#noparse>${</#noparse>${classVar}.${pkVar}<#noparse>}</#noparse>" />
						<#if model.variables.flowFlag?exists && model.variables.flowFlag=='true'>
						<input type="hidden" id="back" name="back" value=""/>
						<input type="hidden" name="formData" id="formData" />
						<input type="hidden" id="voteAgree" name="voteAgree" value="1"/> 
						<input type="hidden" id="taskId" name="taskId" value="<#noparse>${</#noparse>taskId}"/>
						</#if>			
					</form>
				</div>
			</div><!-- end of ibox-content -->
	</div><!-- end of ibox -->
		
	<#if subtables?exists && subtables?size != 0>
	<#list subtables as table>
	<#assign foreignKey=func.convertUnderLine(table.foreignKey) >
	<form id="${table.variables.classVar}Form" style="display:none">
		<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
			<#list table.columnList as col>	
			<#assign colName=func.convertUnderLine(col.columnName)>
			<#if !col.isPK && colName?lower_case!=foreignKey?lower_case>
			<#if (col.colType=="java.util.Date")>
			<tr>
				<th width="20%">${col.comment}: <#if col.isNotNull> <span class="required">*</span></#if></th>
				<td><input type="text" name="${colName}" value="" class="inputText date" validate="{date:true<#if col.isNotNull>,required:true</#if>}" validateName='${col.comment}'/></td>
			</tr>
			
			<#else>
			<tr>
				<th width="20%">${col.comment}: <#if col.isNotNull> <span class="required">*</span></#if></th>
				<td><input type="text" name="${colName}" value=""  class="inputText" validate="{<#if col.isNotNull>required:true<#else>required:false</#if><#if col.colType=='String' && col.length<1000>,maxlength:${col.length}</#if><#if col.colType=='Integer'|| col.colType=='Long'||col.colType=='Float'>,number:true </#if>}"/></td>
			</tr>
			</#if>
			</#if>
			</#list>
		</table>
	</form>
	</#list>
	</#if>
</div>
</body>
</html>
