<%@ Page Title="Quản lý Danh mục" Language="C#" MasterPageFile="~/admin/Admin.Master" Inherits="DAN_CS445_AU.Admin.QuanLyDanhMuc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#13ec13",
                        "background-light": "#f6f8f6",
                        "background-dark": "#102210",
                    },
                    fontFamily: {
                        "display": ["Work Sans", "Noto Sans", "sans-serif"]
                    },
                },
            },
        }
    </script>
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .material-symbols-outlined.fill {
            font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="font-display bg-background-light dark:bg-background-dark min-h-screen">
        <div class="mx-auto max-w-7xl p-6 lg:p-8">
            
            <!-- Page Heading -->
            <div class="flex flex-wrap justify-between gap-4 items-center mb-6">
                <h1 class="text-[#111811] dark:text-white text-4xl font-black leading-tight tracking-[-0.033em]">
                    Quản lý Danh mục Sản phẩm
                </h1>
            </div>

            <!-- Notification Message -->
            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="mb-4 p-4 rounded-lg"></asp:Panel>

            <!-- Main Card -->
            <div class="bg-white dark:bg-[#1C2C1C] rounded-xl shadow-sm overflow-hidden">
                
                <!-- Toolbar -->
                <div class="flex flex-wrap justify-between items-center gap-4 p-4 border-b border-slate-200 dark:border-slate-800">
                    <!-- Search Bar -->
                    <div class="flex-1 min-w-[280px]">
                        <div class="flex w-full items-stretch rounded-lg h-12">
                            <div class="text-[#618961] flex bg-background-light dark:bg-background-dark items-center justify-center pl-4 rounded-l-lg">
                                <span class="material-symbols-outlined">search</span>
                            </div>
                            <asp:TextBox ID="txtSearch" runat="server" 
                                placeholder="Tìm kiếm theo tên danh mục..." 
                                CssClass="form-input flex w-full min-w-0 flex-1 resize-none overflow-hidden rounded-lg text-[#111811] dark:text-white focus:outline-0 focus:ring-2 focus:ring-primary/50 border-none bg-background-light dark:bg-background-dark h-full placeholder:text-[#618961] px-4 rounded-l-none pl-2 text-base font-normal leading-normal"
                                AutoPostBack="true" OnTextChanged="txtSearch_TextChanged">
                            </asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="flex items-center gap-2">
                        <asp:Button ID="btnAddNew" runat="server" Text="Thêm danh mục mới" OnClick="btnAddNew_Click"
                            CssClass="flex cursor-pointer items-center justify-center overflow-hidden rounded-lg h-12 bg-primary text-[#111811] gap-2 text-sm font-bold leading-normal tracking-[0.015em] px-4 border-none" />
                    </div>
                </div>

                <!-- Filters -->
                <div class="flex gap-3 p-4 overflow-x-auto border-b border-slate-200 dark:border-slate-800">
                    <asp:LinkButton ID="lnkFilterAll" runat="server" OnClick="lnkFilterAll_Click"
                        CssClass="flex h-8 shrink-0 items-center justify-center gap-x-2 rounded-full bg-primary/20 dark:bg-primary/30 pl-4 pr-3">
                        <span class="text-[#111811] dark:text-white text-sm font-medium leading-normal">Tất cả</span>
                    </asp:LinkButton>
                    
                    <asp:LinkButton ID="lnkSortName" runat="server" OnClick="lnkSortName_Click"
                        CssClass="flex h-8 shrink-0 items-center justify-center gap-x-2 rounded-full bg-background-light dark:bg-background-dark pl-4 pr-3 text-[#111811] dark:text-gray-300">
                        <span class="text-sm font-medium leading-normal">Sắp xếp theo tên (A-Z)</span>
                        <span class="material-symbols-outlined text-base">arrow_downward</span>
                    </asp:LinkButton>
                    
                    <asp:LinkButton ID="lnkSortQuantity" runat="server" OnClick="lnkSortQuantity_Click"
                        CssClass="flex h-8 shrink-0 items-center justify-center gap-x-2 rounded-full bg-background-light dark:bg-background-dark pl-4 pr-3 text-[#111811] dark:text-gray-300">
                        <span class="text-sm font-medium leading-normal">Sắp xếp theo số lượng</span>
                        <span class="material-symbols-outlined text-base">arrow_downward</span>
                    </asp:LinkButton>
                </div>

                <!-- Data Table -->
                <div class="overflow-x-auto">
                    <asp:GridView ID="gvDanhMuc" runat="server" AutoGenerateColumns="False" 
                        OnRowCommand="gvDanhMuc_RowCommand"
                        OnRowEditing="gvDanhMuc_RowEditing"
                        OnRowDeleting="gvDanhMuc_RowDeleting"
                        CssClass="w-full text-sm text-left"
                        GridLines="None"
                        ShowHeader="true">
                        
                        <HeaderStyle CssClass="text-xs text-[#618961] dark:text-gray-400 uppercase bg-background-light dark:bg-background-dark" />
                        <RowStyle CssClass="bg-white dark:bg-[#1C2C1C] border-b dark:border-slate-800" />
                        
                        <Columns>
                            <asp:TemplateField HeaderText="Tên danh mục">
                                <HeaderStyle CssClass="px-6 py-3" />
                                <ItemStyle CssClass="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white" />
                                <ItemTemplate>
                                    <%# Eval("TieuDe") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Mô tả">
                                <HeaderStyle CssClass="px-6 py-3" />
                                <ItemStyle CssClass="px-6 py-4 text-gray-600 dark:text-gray-400" />
                                <ItemTemplate>
                                    <%# Eval("MoTa") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Số lượng sản phẩm">
                                <HeaderStyle CssClass="px-6 py-3" />
                                <ItemStyle CssClass="px-6 py-4 text-gray-600 dark:text-gray-400" />
                                <ItemTemplate>
                                    <%# Eval("SoLuong") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Danh mục cha">
                                <HeaderStyle CssClass="px-6 py-3" />
                                <ItemStyle CssClass="px-6 py-4 text-gray-600 dark:text-gray-400" />
                                <ItemTemplate>
                                    <%# Eval("parent_id") == DBNull.Value ? "Danh mục gốc" : Eval("ParentName") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Hành động">
                                <HeaderStyle CssClass="px-6 py-3 text-right" />
                                <ItemStyle CssClass="px-6 py-4 text-right" />
                                <ItemTemplate>
                                    <div class="inline-flex gap-2">
                                        <asp:LinkButton ID="btnEdit" runat="server" 
                                            CommandName="Edit" 
                                            CommandArgument='<%# Eval("dm_id") %>'
                                            CssClass="p-2 rounded-lg hover:bg-primary/20 dark:hover:bg-primary/30 text-gray-600 dark:text-gray-400">
                                            <span class="material-symbols-outlined text-base">edit</span>
                                        </asp:LinkButton>
                                        
                                        <asp:LinkButton ID="btnDelete" runat="server" 
                                            CommandName="Delete" 
                                            CommandArgument='<%# Eval("dm_id") %>'
                                            OnClientClick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');"
                                            CssClass="p-2 rounded-lg hover:bg-red-500/10 dark:hover:bg-red-500/20 text-red-500 dark:text-red-400">
                                            <span class="material-symbols-outlined text-base">delete</span>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>

                        <EmptyDataTemplate>
                            <div class="text-center py-12">
                                <span class="material-symbols-outlined text-gray-300 text-6xl">category</span>
                                <p class="text-gray-500 mt-4">Không tìm thấy danh mục nào</p>
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>

                <!-- Pagination -->
                <div class="flex items-center justify-between p-4">
                    <span class="text-sm font-normal text-gray-500 dark:text-gray-400">
                        Hiển thị <span class="font-semibold text-gray-900 dark:text-white"><asp:Literal ID="litPageInfo" runat="server"></asp:Literal></span>
                    </span>
                    
                    <div class="inline-flex items-center -space-x-px">
                        <asp:LinkButton ID="lnkPrevious" runat="server" OnClick="lnkPrevious_Click"
                            CssClass="block px-3 py-2 ml-0 leading-tight text-gray-500 bg-white border border-gray-300 rounded-l-lg hover:bg-gray-100 hover:text-gray-700 dark:bg-[#102210] dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">
                            <span class="material-symbols-outlined text-base">chevron_left</span>
                        </asp:LinkButton>
                        
                        <asp:Literal ID="litPagination" runat="server"></asp:Literal>
                        
                        <asp:LinkButton ID="lnkNext" runat="server" OnClick="lnkNext_Click"
                            CssClass="block px-3 py-2 leading-tight text-gray-500 bg-white border border-gray-300 rounded-r-lg hover:bg-gray-100 hover:text-gray-700 dark:bg-[#102210] dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">
                            <span class="material-symbols-outlined text-base">chevron_right</span>
                        </asp:LinkButton>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Modal Add/Edit Category -->
    <asp:Panel ID="pnlModal" runat="server" Visible="false" CssClass="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
        <div class="bg-white dark:bg-[#1C2C1C] rounded-xl shadow-2xl w-full max-w-2xl mx-4 max-h-[90vh] overflow-y-auto">
            <div class="p-6 border-b border-slate-200 dark:border-slate-800">
                <h2 class="text-2xl font-bold text-[#111811] dark:text-white">
                    <asp:Literal ID="litModalTitle" runat="server">Thêm danh mục mới</asp:Literal>
                </h2>
            </div>
            
            <div class="p-6 space-y-4">
                <asp:HiddenField ID="hdnCategoryId" runat="server" />
                
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Tên danh mục *</label>
                    <asp:TextBox ID="txtTieuDe" runat="server" 
                        CssClass="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-primary/50 bg-white dark:bg-background-dark text-[#111811] dark:text-white"
                        placeholder="Nhập tên danh mục..."></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTieuDe" runat="server" 
                        ControlToValidate="txtTieuDe" 
                        ErrorMessage="Vui lòng nhập tên danh mục" 
                        ForeColor="Red" 
                        Display="Dynamic"
                        CssClass="text-sm mt-1" />
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Mô tả</label>
                    <asp:TextBox ID="txtMoTa" runat="server" TextMode="MultiLine" Rows="4"
                        CssClass="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-primary/50 bg-white dark:bg-background-dark text-[#111811] dark:text-white"
                        placeholder="Nhập mô tả danh mục..."></asp:TextBox>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Số lượng sản phẩm</label>
                    <asp:TextBox ID="txtSoLuong" runat="server" TextMode="Number"
                        CssClass="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-primary/50 bg-white dark:bg-background-dark text-[#111811] dark:text-white"
                        placeholder="0"></asp:TextBox>
                    <asp:RangeValidator ID="rvSoLuong" runat="server" 
                        ControlToValidate="txtSoLuong" 
                        MinimumValue="0" 
                        MaximumValue="999999" 
                        Type="Integer"
                        ErrorMessage="Số lượng phải từ 0 đến 999999" 
                        ForeColor="Red" 
                        Display="Dynamic"
                        CssClass="text-sm mt-1" />
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Danh mục cha</label>
                    <asp:DropDownList ID="ddlParentCategory" runat="server"
                        CssClass="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-primary/50 bg-white dark:bg-background-dark text-[#111811] dark:text-white">
                        <asp:ListItem Value="" Text="-- Danh mục gốc --"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <div class="p-6 border-t border-slate-200 dark:border-slate-800 flex justify-end gap-3">
                <asp:Button ID="btnCancel" runat="server" Text="Hủy" OnClick="btnCancel_Click" CausesValidation="false"
                    CssClass="px-6 py-2.5 rounded-lg text-sm font-medium text-gray-600 bg-gray-100 hover:bg-gray-200 dark:bg-gray-700 dark:text-gray-300 border-none cursor-pointer" />
                
                <asp:Button ID="btnSaveCategory" runat="server" Text="Lưu" OnClick="btnSaveCategory_Click"
                    CssClass="px-6 py-2.5 rounded-lg text-sm font-bold text-[#111811] bg-primary hover:bg-primary/90 border-none cursor-pointer" />
            </div>
        </div>
    </asp:Panel>

</asp:Content>