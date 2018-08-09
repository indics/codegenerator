<#import "function.ftl" as func>
<#assign package=model.variables.package>
<#assign class=model.variables.class>
<#assign path=model.variables.path>
<#assign system=vars.system>
<#assign comment=model.tabComment>
<#assign subtables=model.subTableList>
<#assign classVar=model.variables.classVar>
<#assign pk=func.getPk(model) >
<#assign pkVar=func.convertUnderLine(pk) >
package com.casic.${system}.controller.${package};

import java.util.HashMap;
import java.util.Map;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.cosim.core.annotion.Action;
import org.springframework.web.servlet.ModelAndView;
import com.cosim.core.util.UniqueIdUtil;
import com.cosim.core.util.ContextUtil;
import com.cosim.core.web.util.RequestUtil;
import com.cosim.core.web.controller.BaseController;
import com.casic.core.web.query.JQGridQueryFilter;
import org.springframework.web.bind.annotation.ResponseBody;

import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;

import com.casic.${system}.model.${package}.${class};
import com.casic.${system}.service.${package}.${class}Service;
<#if subtables?exists && subtables?size != 0>
	<#list subtables as table>
import com.casic.${system}.model.${table.variables.package}.${table.variables.class};
	</#list>
</#if>
import com.cosim.core.web.ResultMessage;
<#--直接绑定工作流生成-->
<#if model.variables.flowFlag?exists && model.variables.flowFlag=='true'>
import com.cosim.core.bpm.model.ProcessCmd;
import com.cosim.platform.webservice.api.ProcessService;
</#if>
/**
 *<pre>
 * 对象功能:${comment} 控制器类
 <#if vars.company?exists>
 * 开发公司:${vars.company}
 </#if>
 <#if vars.developer?exists>
 * 开发人员:${vars.developer}
 </#if>
 * 创建时间:${date?string("yyyy-MM-dd HH:mm:ss")}
 *</pre>
 */
@Controller
@RequestMapping("/${system}/${path}/${classVar}/")
public class ${class}Controller extends BaseController
{
	@Resource
	private ${class}Service ${classVar}Service;
	
	<#--直接绑定工作流生成-->
	<#if model.variables.flowFlag?exists && model.variables.flowFlag=='true'>
	@Resource
	private ProcessService processService;
	<#assign defKey=model.variables.flowDefId>
	private final String defKey = "${defKey}";	//绑定流程定义
	</#if>
	
	/**
	 * 添加或更新${comment}。
	 * @param request
	 * @param response
	 * @param ${classVar} 添加或更新的实体
	 * @param bindResult
	 * @param viewName
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("save")
	@Action(description="添加或更新${comment}")
	public void save(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String resultMsg=null;		
		${class} ${classVar}=getFormObject(request);
		try{
			if(${classVar}.get${pkVar?cap_first}()==null||${classVar}.get${pkVar?cap_first}()==0){
				${classVar}.set${pkVar?cap_first}(UniqueIdUtil.genId());
				<#if subtables?exists && subtables?size != 0>
				${classVar}Service.addAll(${classVar});			
				<#else>
				${classVar}Service.add(${classVar});
				</#if>
				resultMsg=getText("record.added","${comment}");
			}else{
			    <#if subtables?exists && subtables?size != 0>
			    ${classVar}Service.updateAll(${classVar});
			    <#else>
			    ${classVar}Service.update(${classVar});
			    </#if>
				resultMsg=getText("record.updated","${comment}");
			}
			writeResultMessage(response.getWriter(),resultMsg,ResultMessage.Success);
		}catch(Exception e){
			writeResultMessage(response.getWriter(),resultMsg+","+e.getMessage(),ResultMessage.Fail);
		}
	}
	
	/**
	 * 取得 ${class} 实体 
	 * @param request
	 * @return
	 * @throws Exception
	 */
    protected ${class} getFormObject(HttpServletRequest request) throws Exception {
    
    	JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher((new String[] { "yyyy-MM-dd" })));
    
		String json=RequestUtil.getString(request, "json");
		JSONObject obj = JSONObject.fromObject(json);
		
		<#if subtables?exists && subtables?size != 0>
		Map<String,  Class> map=new HashMap<String,  Class>();
		<#list subtables as table>
		<#assign vars=table.variables>
		map.put("${vars.classVar}List", ${vars.class}.class);
		</#list>
		${class} ${classVar} = (${class})JSONObject.toBean(obj, ${class}.class,map);
		<#else>
		${class} ${classVar} = (${class})JSONObject.toBean(obj, ${class}.class);
		</#if>
		
		return ${classVar};
    }
	
	/**
	 * 取得${comment}分页列表
	 * @param request
	 * @param response
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("list")
	@Action(description="查看${comment}分页列表")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response) throws Exception
	{	
		List<${class}> list=${classVar}Service.getAll(new JQGridQueryFilter(request));
		ModelAndView mv=this.getAutoView().addObject("${classVar}List",list);
		
		return mv;
	}
	
	/**
	 * 取得${comment}分页列表数据结构
	 * {total:xxx,page:yyy,records:zzz,rows:[{name1:”Row01″,name2:”Row 11″,name3:”Row 12″,name4:”Row 13″,name5:”Row 14″}]}
	 * page:当前页
	 * total:总页数
	 * records:记录数
	 * @param request
	 * @param response
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("listData")
	@ResponseBody
	public Map<String,Object> listData(HttpServletRequest request,HttpServletResponse response) throws Exception
	{	
		JQGridQueryFilter queryFilter = new JQGridQueryFilter(request);
		List<${class}> list = ${classVar}Service.getAll(queryFilter);
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("page", queryFilter.getPageBean().getCurrentPage());
		data.put("total", queryFilter.getPageBean().getTotalPage());	
		data.put("records", queryFilter.getPageBean().getTotalCount());
		data.put("rows", list);
		return data;
	}
	
	/**
	 * 删除${comment}
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("del")
	@Action(description="删除${comment}")
	public void del(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String message=null;
		try{
			Long[] lAryId =RequestUtil.getLongAryByStr(request, "${pkVar}");
			<#if subtables?exists && subtables?size != 0>
			${classVar}Service.delAll(lAryId);
			message = "删除${comment}及其从表成功!";
			writeResultMessage(response.getWriter(),message,ResultMessage.Success);;
			<#else>
			${classVar}Service.delByIds(lAryId);
			message = "删除${comment}及其从表成功!";
			writeResultMessage(response.getWriter(),message,ResultMessage.Success);
			</#if>			
		}catch(Exception ex){
			message= "删除失败" + ex.getMessage();
			writeResultMessage(response.getWriter(),message,ResultMessage.Fail);
		}
	}
	
	/**
	 * 	编辑${comment}
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("edit")
	@Action(description="编辑${comment}")
	public ModelAndView edit(HttpServletRequest request) throws Exception
	{
		Long ${pkVar}=RequestUtil.getLong(request,"${pkVar}");
		String returnUrl=RequestUtil.getPrePage(request);
		${class} ${classVar}=${classVar}Service.getById(${pkVar});
		<#if subtables?exists && subtables?size != 0>
		    <#list subtables as table>
		    <#assign vars=table.variables>
		List<${table.variables.class}> ${table.variables.classVar}List=${classVar}Service.get${vars.classVar?cap_first}List(${pkVar});
		    </#list>
		</#if>
		
		<#if subtables?exists && subtables?size != 0>
		return getAutoView().addObject("${classVar}",${classVar})
		    <#list subtables as table>
							.addObject("${table.variables.classVar}List",${table.variables.classVar}List)
		    </#list>
							.addObject("returnUrl",returnUrl);
		<#else>
		return getAutoView().addObject("${classVar}",${classVar}).addObject("returnUrl", returnUrl);
		</#if>
	}

	/**
	 * 取得${comment}明细
	 * @param request   
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("get")
	@Action(description="查看${comment}明细")
	public ModelAndView get(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		long ${pkVar}=RequestUtil.getLong(request,"${pkVar}");
		${class} ${classVar} = ${classVar}Service.getById(${pkVar});	
		<#if subtables?exists && subtables?size != 0>
		    <#list subtables as table>
		    <#assign vars=table.variables>
		List<${table.variables.class}> ${table.variables.classVar}List=${classVar}Service.get${vars.classVar?cap_first}List(${pkVar});
		    </#list>
		return getAutoView().addObject("${classVar}",${classVar})
		    <#list model.subTableList as table>
							.addObject("${table.variables.classVar}List",${table.variables.classVar}List)<#if !table_has_next>;</#if>
		    </#list>
		<#else>
		return getAutoView().addObject("${classVar}", ${classVar});
		</#if>	
	}
	
<#--直接绑定工作流生成-->
<#if model.variables.flowFlag?exists && model.variables.flowFlag=='true'>
	/**
	 * 添加或更新${comment}<br>
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("apply")
	@Action(description = "添加或更新${comment}")
	public void apply(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String resultMsg = null;
		${class} ${classVar}=getFormObject(request);
		long ${pkVar}=RequestUtil.getLong(request,"${pkVar}");
		try {
			if (${classVar} != null) {
				if (${classVar}.get${pkVar?cap_first}() == null || ${classVar}.get${pkVar?cap_first}() == 0) {
					${classVar}.set${pkVar?cap_first}(UniqueIdUtil.genId());
					${classVar}Service.add(${classVar});
					resultMsg = getText("record.added", "${comment}");
				} else {
					${classVar}Service.update(${classVar});
					resultMsg = getText("record.updated", "${comment}");
				}
				${pkVar} =${classVar}.get${pkVar?cap_first}();
			} 

			ProcessCmd processCmd = new ProcessCmd();
			processCmd.setFlowKey(defKey);
			processCmd.setBusinessKey(String.valueOf(${pkVar}));
			processCmd.setUserAccount(ContextUtil.getCurrentUser().getFullname());
			processService.start(processCmd);

			writeResultMessage(response.getWriter(), "${comment}成功", ResultMessage.Success);
		} catch (Exception e) {
			writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
		}
	}

	/**
	 * 执行下一步<br>
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("complete")
	@Action(description = "执行下一步")
	public void complete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String resultMsg = null;
		String taskId = RequestUtil.getString(request, "taskId");
		String voteAgree = RequestUtil.getString(request, "voteAgree");
		try {
			ProcessCmd processCmd = new ProcessCmd();
			processCmd.setTaskId(taskId);
			processCmd.setUserAccount(ContextUtil.getCurrentUser().getFullname());
			processCmd.setVoteAgree(new Short(voteAgree));
			processService.doNext(processCmd);

			writeResultMessage(response.getWriter(), "执行成功" + "1", ResultMessage.Success);
		} catch (Exception e) {
			writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
		}
	}
</#if>	
}