<template>
    <el-card shadow="never" class="index">
        <template #header>
            <div class="card_header">
                <b>部门</b>
                <div>
                    <el-button color="#3388BB" @click="addDialogFormVisible = true">增加</el-button>
                    <el-button color="#3388BB" @click="searchDialogFormVisible = true">搜索</el-button>
                     <el-button color="#3388BB" @click="preSelect()">筛选</el-button>
                </div>
            </div>
        </template>
        <!-- <el-empty description="暂无数据"></el-empty> -->

        <el-table :data="tableData" stripe style="width: 100%">
            <el-table-column prop="depart_no" label="部门号"></el-table-column>
            <el-table-column prop="id" label="管理者员工号"></el-table-column>
            <el-table-column prop="bank_name" label="支行名称"></el-table-column>
            <el-table-column label="部门名称">
                <template #default="scope">
                    <el-input v-show="scope.row.showmode" v-model="scope.row.depart_name"></el-input>
                    <p v-show="!scope.row.showmode">{{ scope.row.depart_name }}</p>
                </template>
            </el-table-column>
            <el-table-column label="部门类型">
                <template #default="scope">
                    <el-input v-show="scope.row.showmode" v-model="scope.row.depart_type"></el-input>
                    <p v-show="!scope.row.showmode">{{ scope.row.depart_type }}</p>
                </template>
            </el-table-column>
            <el-table-column fixed="right" label="操作" width=300px>
                <template #default="scope">
                    <el-button @click="scope.row.showmode = true" type='primary' size="small">编辑</el-button>
                    <el-button @click="handleEdit(scope.row)" type='success' size="small">保存</el-button>
                    <el-button @click="handleDelete(scope.row)" type='danger' size="small">删除</el-button>
                </template>
            </el-table-column>
        </el-table>

        <div style="padding: 10px 0">
            <el-pagination v-model:current-page="currentPage" v-model:page-size="pageSize" :page-sizes="[2, 4, 10, 20]"
                layout="total, sizes, prev, pager, next, jumper" :total="count" @size-change="handleSizeChange"
                @current-change="handleCurrentChange" />
        </div>

        <el-dialog v-model="addDialogFormVisible" title="增加">
            <el-form :model="addForm">
                <el-form-item label="部门号" label-width=100px>
                    <el-input v-model="addForm.depart_no" autocomplete="off" />
                </el-form-item>
                <el-form-item label="支行名称" label-width=100px>
                    <el-input v-model="addForm.bank_name" autocomplete="off" />
                </el-form-item>
                <el-form-item label="部门名称" label-width=100px>
                    <el-input v-model="addForm.depart_name" autocomplete="off" />
                </el-form-item>
                <el-form-item label="部门类型" label-width=100px>
                    <el-input v-model="addForm.depart_type" autocomplete="off" />
                </el-form-item>
            </el-form>
            <template #footer>
                <span class="dialog-footer">
                    <el-button @click="addDialogFormVisible = false">取消</el-button>
                    <el-button color="#3388BB" type="primary" @click="handleAdd()">确定</el-button>
                </span>
            </template>
        </el-dialog>

        <el-dialog v-model="searchDialogFormVisible" title="搜索">
            <el-form :model="searchForm">
                <el-form-item label="部门号" label-width=100px>
                    <el-input v-model="searchForm.depart_no" autocomplete="off" />
                </el-form-item>
                <el-form-item label="部门名称" label-width=100px>
                    <el-input v-model="searchForm.depart_name" autocomplete="off" />
                </el-form-item>
            </el-form>
            <template #footer>
                <span class="dialog-footer">
                    <el-button @click="searchDialogFormVisible = false">取消</el-button>
                    <el-button color="#3388BB" type="primary" @click="handleSearch()">确定</el-button>
                </span>
            </template>
        </el-dialog>

        <el-dialog v-model="selectDialogFormVisible" title="筛选">
            <el-form :model="searchForm">
                 <el-form-item label="管理者员工号" label-width=100px>
                      <el-select v-model="searchForm.id" >
                        <el-option v-for="id in uniqueId" :key="id" :label="id" :value="id"></el-option>
                    </el-select>  
                </el-form-item>
                <el-form-item label="支行名称" label-width=100px>
                    <el-select v-model="searchForm.bank_name" >
                        <el-option v-for="bank_name in uniqueBankName" :key="bank_name" :label="bank_name" :value="bank_name"></el-option>
                    </el-select> 
                </el-form-item>
                 <el-form-item label="部门类型" label-width=100px>
                    <el-select v-model="searchForm.depart_type" >
                        <el-option v-for="depart_type in uniqueDepType" :key="depart_type" :label="depart_type" :value="depart_type"></el-option>
                    </el-select> 
                </el-form-item>
            </el-form>
            <template #footer>
                <span class="dialog-footer">
                    <el-button @click="cleanSelect()">重置</el-button>
                    <el-button color="#3388BB" type="primary" @click="handleSelect()">确定</el-button>
                </span>
            </template>
        </el-dialog>
    </el-card>
</template>

<script>
import { ref, onMounted ,onUnmounted} from "vue";
import request from "@/utils/axios";
import { reactive } from "vue";
import { ElMessage } from "element-plus";
import { eventBus } from '@/utils/eventBus.js';

const bank_name = ref('');
const handleUpdate =(data)=>{ bank_name.value=data;  }
eventBus.on('updateSearchForm', handleUpdate);
if(bank_name.value!=''){searchForm.bank_name=bank_name.value;} 

export default {
    setup() {
        const tableData = ref([]) ;
        const fullData = ref([]) ;
        const addDialogFormVisible = ref(false);
        const searchDialogFormVisible = ref(false);
        const selectDialogFormVisible =ref(false);
        const addForm = reactive({
            depart_no: "",
            id: "",
            bank_name: "",
            depart_name: "",
            depart_type: "",
        });
        const searchForm = reactive({
            depart_no: "",
            id: "",
            bank_name: "",
            depart_name: "",
            depart_type: "",
        });
        const currentPage = ref(1);
        const pageSize = ref(2);
        const count = ref(0);
        const baseurl = "/department";
        const uniqueBankName = ref([]);
        const uniqueDepType = ref([]);
        const uniqueId =ref ([]);


        const load = () => {
            request({ url: baseurl + "/page", method: "post", params: { page: currentPage.value, size: pageSize.value }, data: searchForm }).then(res => {
                if (res.data.code == 200) {
                    tableData.value = res.data.data.data;
                    count.value = res.data.data.count;
                } else {
                    ElMessage.error(res.data.code + "：" + res.data.message);
                }
            }).catch(err => {
                ElMessage.error(err);
            });
        };
        const initData = () =>{
             request({ url: baseurl + "/page", method: "post", params: { page: 1, size: 1000 }, data: searchForm }).then(res => {
                if (res.data.code == 200) {
                    fullData.value =res.data.data.data;
                    console.log(fullData);
                } else {
                    ElMessage.error(res.data.code + "：" + res.data.message);
                }
            }).catch(err => {
                ElMessage.error(err);
            });
        }
        
       
      


         onMounted(() => {
            initData();
            if(bank_name.value!=''){searchForm.bank_name=bank_name.value;}  
            load();  
        });

     

        const handleEdit = (data) => {
            request.post(baseurl + "/edit", data).then(res => {
                load();
                if (res.data.code == 200) {
                    ElMessage.success(res.data.message);
                } else {
                    ElMessage.error(res.data.code + "：" + res.data.message);
                }
            }).catch(err => {
                ElMessage.error(err);
            });
            data.showmode = false;
        };

        const handleDelete = (data) => {
            request.post(baseurl + "/delete", data).then(res => {
                load();
                if (res.data.code == 200) {
                    ElMessage.success(res.data.message);
                } else {
                    ElMessage.error(res.data.code + "：" + res.data.message);
                }
            }).catch(err => {
                ElMessage.error(err);
            });
        };

        const handleSizeChange = (number) => {
            pageSize.value = number;
            load();
        };

        const handleCurrentChange = (number) => {
            currentPage.value = number;
            load();
        };

        const handleAdd = () => {
            request.post(baseurl + "/add", addForm).then(res => {
                load();
                if (res.data.code == 200) {
                    ElMessage.success(res.data.message);
                } else {
                    ElMessage.error(res.data.code + "：" + res.data.message);
                }
            }).catch(err => {
                ElMessage.error(err);
            });
            addDialogFormVisible.value = false;
            Object.keys(addForm).forEach(key => {
                addForm[key] = "";
            });
        };
        const preSelect =() =>{
            selectDialogFormVisible.value = true;
            uniqueBankName.value= Array.from(new Set(fullData._rawValue.map(item => item.bank_name)));
            uniqueId.value= Array.from(new Set(fullData._rawValue.map(item => item.id)));
            uniqueDepType.value=Array.from(new Set(fullData._rawValue.map(item => item.depart_type)));
       }

        //用于筛选
       const handleSelect =() =>{
            load ();
            selectDialogFormVisible.value = false;     
       }

       //重置筛选结果
       const cleanSelect =() =>{
            Object.keys(searchForm).forEach(key => {
                searchForm[key] = "";
            });
       }

        const handleSearch = () => {
            load();
            searchDialogFormVisible.value = false;
            Object.keys(searchForm).forEach(key => {
                searchForm[key] = "";
            });
        };

        onUnmounted(() => {
           bank_name.value='';
        });
        return {
            tableData,
            addDialogFormVisible,
            searchDialogFormVisible,
            selectDialogFormVisible,
            addForm,
            searchForm,
            bank_name,
            currentPage,
            pageSize,
            count,
            uniqueBankName,
            uniqueDepType,
            uniqueId,
            handleEdit,
            handleDelete,
            handleSizeChange,
            handleCurrentChange,
            handleAdd,
            handleSearch,
            handleSelect,
            preSelect,
            cleanSelect,
            handleUpdate
        };
    }
}
</script>

<style lang="scss" scoped>
.card_header {
    display: flex;
    align-items: center;
    justify-content: space-between;
}




</style>
