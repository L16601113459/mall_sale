package com.atguigu.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.bean.OBJECT_T_MALL_ATTR;
import com.atguigu.bean.OBJECT_T_MALL_SKU;
import com.atguigu.service.AttrServiceInf;
import com.atguigu.service.ListServiceInf;

@Controller
public class IndexController {

	@Autowired
	AttrServiceInf attrServiceInf;

	@Autowired
	ListServiceInf listServiceInf;

	@RequestMapping("goto_list")
	public String goto_list(int flbh2, ModelMap map) {

		// flbh2属性的集合
		List<OBJECT_T_MALL_ATTR> list_attr = attrServiceInf.get_attr_list(flbh2);

		// flbh2商品列表
		List<OBJECT_T_MALL_SKU> list_sku = listServiceInf.get_list_by_flbh2(flbh2);

		map.put("list_attr", list_attr);
		map.put("list_sku", list_sku);
		map.put("flbh2", flbh2);
		return "list";
	}

	@RequestMapping("goto_login")
	public String goto_login(HttpServletRequest request, ModelMap map) {

		return "login";
	}

	@RequestMapping("index")
	public String index(HttpServletRequest request, ModelMap map) {

		/*
		 * String yh_mch = ""; Cookie[] cookies = request.getCookies(); if
		 * (cookies != null && cookies.length > 0) { for (int i = 0; i <
		 * cookies.length; i++) { String name = cookies[i].getName(); if
		 * (name.equals("yh_mch")) { yh_mch = cookies[i].getValue(); } } }
		 * map.put("yh_mch", yh_mch);
		 */
		return "index";
	}

}
