<%--
  Created by IntelliJ IDEA.
  User: HUAWEI
  Date: 2022/12/23
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<SCRIPT>
    rendTree();
    function rendTree() {
        $.ajax({
            url:"<%=request.getContextPath() %>/TreeInfo/queryCategoryTreeNode",
            type:"get",
            cache: false,
            contentType:"text/json",
            success: function(rel) {
                debugger;
                var data = rel;
                var dataJson = toTreeData(data);
            }
        });
    }




    function toTreeData(data) {
        debugger;
        var tree = [];
        var resData = data;
        for (var i = 0; i < resData.length; i++){
            if (resData[i].id == 2) {
                var obj = {
                    id: resData[i].id,
                    title: resData[i].text,
                    parentId: "0",
                    children: []
                };
                tree.push(obj);
                resData.splice(i,1);
                i--;
            }
        }

        var run = function(treeAttrs){
            if (resData.length > 0 ) {
                for (var i = 0; i < treeAttrs.length; i++) {
                    for (var j = 0; j < resData.length; j++) {
                        if (resData[j]) {
                            if (treeAttrs[i].id === resData[j].pid) {
                                var obj = {
                                    id: resData[j].id,
                                    title: resData[j].text,
                                    parentId: resData[j].pid,
                                    children: []
                                };
                                treeAttrs[i].children.push(obj);
                                resData.splice(j,1);
                                j--;
                            }
                        }
                        run(treeAttrs[i].children);
                    }
                }
            }
        };
        run(tree);
        return tree;
    }

</SCRIPT>
</body>
</html>
