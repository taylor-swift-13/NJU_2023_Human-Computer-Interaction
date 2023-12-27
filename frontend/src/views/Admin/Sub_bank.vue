<template>
    <el-card shadow="never" class="index">
        <template #header>
            <div class="card_header">
                <b>支行管理</b>
                <div>
                    <el-button color="#3388BB" @click="addDialogFormVisible = true">增加</el-button>
                    <el-button color="#3388BB" @click="searchDialogFormVisible = true">搜索</el-button>
                    <el-button color="#3388BB" @click="preSelect()">筛选</el-button>
                </div>
            </div>
        </template>
        <!-- <el-empty description="暂无数据"></el-empty> -->

        <el-table :data="tableData" stripe style="width: 100%">
            <el-table-column prop="bank_name" label="支行名称"></el-table-column>
            <el-table-column label="支行位置">
                <template #default="scope">
                    <el-input v-show="scope.row.showmode" v-model="scope.row.bank_location"></el-input>
                    <p v-show="!scope.row.showmode">{{ scope.row.bank_location }}</p>
                </template>
            </el-table-column>
            <el-table-column label="总资产">
                <template #default="scope">
                    <el-input v-show="scope.row.showmode" v-model="scope.row.asset"></el-input>
                    <p v-show="!scope.row.showmode">{{ scope.row.asset }}</p>
                </template>
            </el-table-column>
            <el-table-column label="操作" width="350">
                <template #default="scope" >
                    <el-button @click="scope.row.showmode = true" type='primary' size="small">编辑</el-button>
                    <el-button @click="handleEdit(scope.row)" type='success' size="small">保存</el-button>
                    <el-button @click="preRename(scope.row)" type='info' size="small">改名</el-button>
                     <router-link to="/department/department" class="link">
                        <el-button @click="updateSerachForm(scope.row.bank_name)"  size="small">
                             部门
                        </el-button>
                     </router-link>
                      <router-link to="/department/member" class="link">
                        <el-button @click="updateSerachForm(scope.row.bank_name)"  size="small">
                            员工
                        </el-button>
                     </router-link>
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
                <el-form-item label="支行名称" label-width=100px>
                    <el-input v-model="addForm.bank_name" autocomplete="off" />
                </el-form-item>
                <el-form-item label="支行位置" label-width=100px>
                    <el-input v-model="addForm.bank_location" autocomplete="off" />
                </el-form-item>
                <el-form-item label="总资产" label-width=100px>
                    <el-input v-model="addForm.asset" autocomplete="off" />
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
                <el-form-item label="支行名称" label-width=100px>
                    <el-input v-model="searchForm.bank_name" autocomplete="off" />   
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
                <el-form-item label="支行位置" label-width=100px>
                    <el-select v-model="searchForm.bank_location" >
                        <el-option v-for="location in uniqueBankLocation" :key="location" :label="location" :value="location"></el-option>
                    </el-select>  
                </el-form-item>
                <el-form-item label="总资产" label-width=100px>
                    <el-select v-model="searchForm.asset">
                        <el-option v-for="asset in uniqueAsset" :key="asset" :label="asset" :value="asset"></el-option>
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

        

        <el-dialog v-model="renameDialogFormVisible" title="支行改名">
            <el-form :model="nameForm">
                <el-form-item label="新名称" label-width=100px>
                    <el-input v-model="nameForm.name_new" autocomplete="off" />
                </el-form-item>
            </el-form>
            <template #footer>
                <span class="dialog-footer">
                    <el-button @click="renameDialogFormVisible = false">取消</el-button>
                    <el-button type="primary" @click="handleRename()">确定</el-button>
                </span>
            </template>
        </el-dialog>

    </el-card>
</template>

<script>
import { ref, onMounted } from "vue";
import request from "@/utils/axios";
import { reactive } from "vue";
import { ElMessage } from "element-plus";

import { eventBus } from '@/utils/eventBus.js';



export default {
    setup() {
        const tableData = ref([])
        const fullData = ref([])
        const addDialogFormVisible = ref(false);
        const searchDialogFormVisible = ref(false);
        const selectDialogFormVisible =ref(false);
        const renameDialogFormVisible = ref(false);
        const addForm = reactive({
            bank_name: "",
            bank_location: "",
            asset: "",
        });
        const searchForm = reactive({
            bank_name: "",
            bank_location: "",
            asset: "",
        });
        const nameForm = reactive({
            name: "",
            name_new: "",
        });

        const currentPage = ref(1);
        const pageSize = ref(2);
        const count = ref(0);
        const baseurl = "/subBank";
        const uniqueBankLocation =ref([]);
        const uniqueAsset =ref([]);
        
        const initData = () =>{
             request({ url: baseurl + "/page", method: "post", params: { page: 1, size: 1000 }, data: searchForm }).then(res => {
                if (res.data.code == 200) {
                    fullData.value =res.data.data.data;
                } else {
                    ElMessage.error(res.data.code + "：" + res.data.message);
                }
            }).catch(err => {
                ElMessage.error(err);
            });
        }

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

        onMounted(() => {
            initData();
            load();


            import('@/views/Department/Department.vue').then(({default:dep}) => {
                const handleUpdate =(data)=>{ dep.bank_name=data;  }
                eventBus.on('updateSearchForm', handleUpdate);
          });

            import('@/views/Department/Member.vue').then(({default:mem}) => {
                const handleUpdate =(data)=>{ mem.bank_name=data;  }
                eventBus.on('updateSearchForm', handleUpdate);
          });

        });

       const preSelect =() =>{
            selectDialogFormVisible.value = true;
            uniqueBankLocation.value= Array.from(new Set(fullData._rawValue.map(item => item.bank_location)));
            uniqueAsset.value= Array.from(new Set(fullData._rawValue.map(item => item.asset)));
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

    

        const preRename = (data) => {
            nameForm.name = data.bank_name;
            renameDialogFormVisible.value = true;
        };

        const handleRename = () => {
            request.post(baseurl + "/rename", nameForm).then(res => {
                load();
                if (res.data.code == 200) {
                    ElMessage.success(res.data.message);
                } else {
                    ElMessage.error(res.data.code + "：" + res.data.message);
                }
            }).catch(err => {
                ElMessage.error(err);
            });
            renameDialogFormVisible.value = false;
            Object.keys(nameForm).forEach(key => {
                nameForm[key] = "";
            });
        }

        const updateSerachForm = (data) => {
            eventBus.emit('updateSearchForm', data);
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
        const handleSearch = () => {
            load();
            searchDialogFormVisible.value = false;
            Object.keys(searchForm).forEach(key => {
                searchForm[key] = "";
            });
        };


        return {
            tableData,
            addDialogFormVisible,
            searchDialogFormVisible,
            selectDialogFormVisible,
            renameDialogFormVisible,
            addForm,
            searchForm,
            nameForm,
            currentPage,
            pageSize,
            count,
            uniqueBankLocation,
            uniqueAsset,
            handleEdit,
            handleDelete,
            handleSizeChange,
            handleCurrentChange,
            handleAdd,
            handleSearch,
            preRename,
            handleRename,
            handleSelect,
            cleanSelect, 
            preSelect,
            updateSerachForm

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
.link{
   padding-left:10px;
}



</style>
