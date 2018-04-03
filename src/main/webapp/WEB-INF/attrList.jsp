<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";%>
<base href="<%=basePath %>" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
		function save_param(shxm_id,shxzh_id,shxzh_mch){
			$("#paramArea").append("<input name='shxparam' type='hidden' value='{\"shxm_id\":"+shxm_id+",\"shxzh_id\":"+shxzh_id+"}'/>"+'<span onclick=show_attr('+shxm_id+',this)>'+' '+shxzh_mch+'</span>');
			//ajax异步请求
			get_list_by_attr();
		}
		
		function get_list_by_attr(){
			//获得参数
			var jsonStr="flbh2="+${flbh2};
			$("#paramArea input[name='shxparam']").each(function(i,data){
				var json = $.parseJSON(data.value);
				jsonStr = jsonStr + "&list_attr["+i+"].shxm_id="+json.shxm_id+"&list_attr["+i+"].shxzh_id="+json.shxzh_id;
			})
			//异步提交
			//刷新商品列表
			$.post("get_list_by_attr.do",jsonStr,function(data){
			   $("#skuListInner").html(data);
			});
		}
		
		function hidde_attr(id){
			$("#"+id).attr("style","display:none");
		}
		
		function show_attr(id,obj){
			$("#"+id).attr("style","display:block");
			// 获取当前元素的相邻元素并删除
			$(obj).prev("input").remove();
			$(obj).remove();
			
			//需要判断是否还存在筛选条件
			var i=$("#paramArea input[name='shxparam']").size();
			//alert(i);
			
			if(i>0){
				//若存在条件，直接调用方法
				get_list_by_attr();
			}else{
				//若条件不存在，需要查询全部该flbh2下的所有商品，回到IndexController的goto_list方法？
				window.location.href="goto_list.do?flbh2="+${flbh2};
			}
		}
</script>
</head>
<body>
		<div id="paramArea"></div>
		<hr>
		属性列表
		<hr>
		<c:if test="${!empty list_attr }">
			<c:forEach items="${list_attr }" var="attr">
				<div id="${attr.id}" style="display:block">
					${ attr.shxm_mch } :
						<c:forEach items="${attr.list_value }" var="value" >
							<a  href="javascript:save_param(${attr.id},${ value.id},'${value.shxzh }${value.shxzh_mch }');" onclick="hidde_attr(${attr.id})">${value.shxzh } ${value.shxzh_mch }</a>
						</c:forEach>
				</div>
				<br>
		    </c:forEach>
		</c:if>
		
		<c:if test="${empty list_attr }">
		    属性为空！
		</c:if>
</body>
</html>