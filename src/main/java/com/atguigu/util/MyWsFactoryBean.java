package com.atguigu.util;

import org.apache.cxf.jaxws.JaxWsProxyFactoryBean;
import org.springframework.beans.factory.FactoryBean;

public class MyWsFactoryBean<T> implements FactoryBean<T> {

	private String url;
	private Class<T> t;

	public static <T> T getMyWs(String url, Class<T> t) {
		JaxWsProxyFactoryBean jwfb = new JaxWsProxyFactoryBean();
		jwfb.setAddress(url);
		jwfb.setServiceClass(t);
		T bean = (T) jwfb.create();
		return bean;
	}
	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Class<T> getT() {
		return t;
	}

	public void setT(Class<T> t) {
		this.t = t;
	}

	@Override
	public T getObject() throws Exception {
		return getMyWs(url, this.t);
	}

	@Override
	public Class<?> getObjectType() {
		return t;
	}

	@Override
	public boolean isSingleton() {
		return false;
	}

}
