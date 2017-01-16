package com.oneseven.app;

import static spark.Spark.*;

import java.io.StringWriter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.oneseven.app.config.RouteSpark;
import com.oneseven.app.dao.UserDao;
import com.oneseven.app.model.*;

import freemarker.template.Configuration;
import freemarker.template.Template;

public class App {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		// Configure Freemark
		final Configuration configuration = new Configuration();
		configuration.setClassForTemplateLoading(App.class, "/");

		final Gson gson = new Gson();

		get(RouteSpark.ROOT, (req, res) -> {
			Map<String, Object> fruitMap = new HashMap<>();
			StringWriter writer = new StringWriter();
			try {
				//public/spark/service
				Template template = configuration.getTemplate("main.ftl");
				fruitMap.put("urls", Arrays.asList(
						"http://localhost:4567/",
						"http://localhost:4567/users",
						"http://localhost:4567/user/:id"
				));
				template.process(fruitMap, writer);
				return writer;
			} catch (Exception e) {
				halt(500);
				return null;
			}
		});

		get(RouteSpark.USERS, (req, res) -> {
			res.type("application/json");
			try {
				List<User> list = UserDao.Instance().listUsers();
				return list;
			} catch (Exception e) {
				halt(500);
				return null;
			}
		}, gson::toJson);
	}

}
