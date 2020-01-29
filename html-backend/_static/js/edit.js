layui.use(['jquery', 'form', 'layer'], function() { 
	// 加载默认的编辑页面
	$ = layui.jquery, form = layui.form, layer = layui.layer;
	var url = getQuery('url');
	var controller = url.split('/')[0];
	var id = getQuery('id');
	var action = controller + '/';
	if (id && id !== '') { 
		action += 'update';
		$("#form-content").append('<input type="hidden" id="id" name="id" value="' + id + '" />');
	} else { 
		action += 'create';
	}

	setForm(url, $("#form-content"), function() { 
		$("#form-content").attr("action", action);
		form.render();
		var conf = routers[controller];
		if (conf.length >= 3) { 
			conf[2]();
			form.render();
		}
	});

	// 提交数据的验证
	form.verify({ //自定义验证规则
		nikename: function(value) {
			if (value.length < 5) {
				return '昵称至少得5个字符啊';
			}
		},
		pass: [/(.+){6,12}$/, '密码必须6到12位'],
		repass: function(value) {
			if ($('#L_pass').val() != $('#L_repass').val()) {
				return '两次密码不一致';
			}
		}
	});

	//监听提交
	form.on('submit(save)', function(data) {
		$.ajax({
			url: "http://127.0.0.1:8801/v1/" + action,
			type: "post",
			dataType: "json",
			data: JSON.stringify(data.field),
			success: function(res) { 
				console.log(res);
				if (res.code === 200) { 
					layer.alert('保存成功', { icon: 6 }, function() { 
						xadmin.close();
						xadmin.father_reload();
					});
					return;
				}
				layer.alert(res.message, { icon: 7 });
			},
			error: function(res) { 
				layer.alert(res.message, { icon: 7 });
			}
		});
		return false;
	});
});

