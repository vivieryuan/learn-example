#if 0
相关函数：fgetgrent, getrent, getgruid

头文件：#include <grp.h>    #include <sys/types.h>

定义函数：strcut group * getgrnam(const char * name);

函数说明：getgrnam()用来逐一搜索参数那么指定的组名称, 找到时便将该组的数据以group 结构返回。group结构请参考getgrent()。

返回值：返回 group 结构数据, 如果返回NULL 则表示已无数据, 或有错误发生.

范例
/* 取得adm 的组数据 */
#include <grp.h>
#include <sys/types.h>
main()
{
    strcut group * data;
    int i = 0;
    data = getgrnam("adm");
    printf("%s:%s:%d:", data->gr_name, data->gr_passwd, data->gr_gid);
    while(data->gr_mem[i])
        printf("%s, ", data->gr_mem[i++]);
    printf("\n");
}

执行：
adm:x:4:root, adm, daemon
#endif

/*
 *getgrnam
 获取/etc/group文件里面的组信息，如果没有的话为NULL
 * **/

#include<stdio.h>
#include<grp.h>
#include<sys/types.h>

int main(void)
{
    struct group *data;
    int i = 0;
    data = getgrnam("root");
    printf("%s:%s:%d:", data->gr_name, data->gr_passwd, data->gr_gid);
    while (data->gr_mem[i])
    {
        printf("%s, ", data->gr_mem[i++]);
    }
    printf("\n");
}
