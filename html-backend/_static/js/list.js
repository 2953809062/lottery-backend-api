layui.use(['jquery', 'laydate', 'form'], function() { 
	var $ = layui.jquery, form = layui.form;

	// 设置搜索框
	var url = getQuery();
	var uArr = url.split("/");
	var urlHtml = url;
	if (uArr.length !== 2) { 
		urlHtml = url + "/index";
	}
	setHtml(urlHtml, $("#form-search"), function() {
        var laydate = layui.laydate;
        //var form = layui.form;
        //执行一个laydate实例
        laydate.render({
            elem: '#start' //指定元素
        });
        //执行一个laydate实例
        laydate.render({
            elem: '#end' //指定元素
        });
		var conf = routers[url];
		if (conf && conf.length >= 2) { 
			conf[1]();
		}
		form.render();
	});

	// 设置nav
	var nArr = getQuery("tab").split("|");
	$("#nav-main").text(nArr[0]);
	$("#nav-sub").text(nArr[1]);
	
	// 设置弹出的编辑框
	$("#action-create").click(function() { 
		showEditDialog(url);
	});
	
	loadRows(url);

	//监听提交
	form.on('submit(search)', function(data) {
		var queries = $("#form-search").serialize();
			
		var uStr = '';
		var sArr = queries.split('&');
		for (var i = 0; i < sArr.length; i++) { 
			if (sArr[i] === '') { 
				continue;
			}
			var tArr = sArr[i].split('=');
			if (tArr[1] === '') { 
				continue;
			}
			uStr += '&' + sArr[i];
		}
		var page = $("em:eq(1)", $("#pager")).text();
		if (!page || page === '') { 
			page = '1';
		}
		if (uStr === '') { 
			return false;
		}
		var realUrl = url + '?' + (uStr.length > 1 ? uStr.substring(1) : '');
		var pageUrl = setQuery(realUrl, 'page', page);
		loadRows(pageUrl);
		return false;
	});

});
