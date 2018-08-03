<#import "function.ftl" as func>
<#assign class=model.variables.class>
<#assign classVar=model.variables.classVar> 
<#assign tabComment=model.tabComment> 
<#assign commonList=model.commonList>
<#assign subtables=model.subTableList>

<%--
	time:${date?string("yyyy-MM-dd HH:mm:ss")}
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>${tabComment}明细</title>
<%@include file="/commons/include/getById.jsp"%>
<script type="text/javascript">
	//放置脚本
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">${tabComment}详细信息</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<a class="link back" href="list.ht">返回</a>
					</div>
				</div>
			</div>
		</div>
		<div class="panel-body">
		<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
			<#list commonList as col> <#assign colName=func.convertUnderLine(col.columnName)>
			<tr>
				<th width="20%">${col.comment}:</th>
				<#if col.colType=="java.util.Date">
				<td>
				<fmt:formatDate value="<#noparse>${</#noparse>${classVar}.${colName}}" pattern="yyyy-MM-dd"/>
				</td>
				<#else>
				<td><#noparse>${</#noparse>${classVar}.${colName}}</td>
				</#if>
			</tr>
			</#list>
		</table>
		<#if subtables?exists && subtables?size != 0>
		<#list subtables as table>
		<#assign foreignKey=func.convertUnderLine(table.foreignKey) >
		<table class="table-grid table-list" cellpadding="1" cellspacing="1">
			<tr>
				<td colspan="${table.columnList?size-2}" style="text-align: center">${table.tableName } :${table.tabComment }</td>
			</tr>
			<tr>
				<#list table.columnList as col>
				<#assign colName=func.convertUnderLine(col.columnName?lower_case)>
				<#if !(col.isPK) && colName?lower_case!=foreignKey?lower_case>							                              
				<th>${col.comment}</th>
				</#if>									
				</#list>
			</tr>	
			<c:forEach items="<#noparse>${</#noparse>${table.variables.classVar}List}" var="${table.variables.classVar}Item" varStatus="status">
				<tr>
					<#list table.columnList as col>												
					<#assign colName=func.convertUnderLine(col.columnName)>
					<#if (col.isPK)>
						<input type="hidden" id="${colName}" name="${colName}" value="<#noparse>${</#noparse>${table.variables.classVar}Item.${colName}}"  class="inputText"/>
					<#elseif (col.colType=="java.util.Date")>
						<td style="text-align: center"><fmt:formatDate value='<#noparse>${</#noparse>${table.variables.classVar}Item.${colName}}' pattern='yyyy-MM-dd'/></td>								
					<#elseif colName?lower_case!=foreignKey?lower_case>
						<td style="text-align: center"><#noparse>${</#noparse>${table.variables.classVar}Item.${colName}}</td>								
					</#if>
					</#list>
				</tr>
			</c:forEach>
		</table>
			</#list>
			</#if>
		</div>
		
	</div>
</body>
</html>

