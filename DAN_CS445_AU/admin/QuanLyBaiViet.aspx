<%@ Page Title="Quản lý bài viết" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLyBaiViet.aspx.cs" Inherits="DAN_CS445_AU.QuanLyBaiViet" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <header class="flex flex-wrap justify-between items-center gap-4 mb-6">
        <h1 class="text-gray-900 dark:text-white text-3xl font-bold leading-tight tracking-tight">Quản lý Bài viết</h1>
        <button type="button" class="flex min-w-[84px] cursor-pointer items-center justify-center gap-2 overflow-hidden rounded-lg h-10 px-4 bg-primary text-white text-sm font-bold leading-normal tracking-wide shadow-sm hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-primary/50">
            <span class="material-symbols-outlined">add</span>
            <span class="truncate">Thêm bài viết mới</span>
        </button>
    </header>

    <div class="bg-white dark:bg-gray-900/50 rounded-xl shadow p-4 mb-6">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div class="md:col-span-2">
                <label class="flex flex-col w-full h-12">
                    <div class="flex w-full flex-1 items-stretch rounded-lg h-full">
                        <div class="text-gray-500 dark:text-gray-400 flex bg-gray-100 dark:bg-gray-800 items-center justify-center pl-4 rounded-l-lg border-r-0">
                            <span class="material-symbols-outlined">search</span>
                        </div>
                        
                        <asp:TextBox ID="txtSearch" runat="server" 
                            AutoPostBack="true" 
                            OnTextChanged="txtSearch_TextChanged"
                            CssClass="form-input flex w-full min-w-0 flex-1 resize-none overflow-hidden rounded-r-lg text-gray-900 dark:text-white focus:outline-0 focus:ring-2 focus:ring-primary/50 border-none bg-gray-100 dark:bg-gray-800 h-full placeholder:text-gray-500 dark:placeholder:text-gray-400 px-4 pl-2 text-base font-normal leading-normal" 
                            placeholder="Tìm kiếm theo tiêu đề..."></asp:TextBox>
                    </div>
                </label>
            </div>
            
            <div class="flex items-center gap-3 overflow-x-auto">
                <button type="button" class="flex h-10 shrink-0 items-center justify-center gap-x-2 rounded-lg bg-gray-100 dark:bg-gray-800 px-4 text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-700">
                    <p class="text-sm font-medium leading-normal">Trạng thái</p>
                    <span class="material-symbols-outlined text-base">expand_more</span>
                </button>

                <button type="button" class="flex h-10 shrink-0 items-center justify-center gap-x-2 rounded-lg bg-gray-100 dark:bg-gray-800 px-4 text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-700">
                    <p class="text-sm font-medium leading-normal">Tác giả</p>
                    <span class="material-symbols-outlined text-base">expand_more</span>
                </button>
            </div>
        </div>
    </div>

    <div class="bg-white dark:bg-gray-900/50 rounded-xl shadow overflow-x-auto">
        <table class="w-full text-sm text-left text-gray-600 dark:text-gray-400">
            <thead class="text-xs text-gray-700 dark:text-gray-300 uppercase bg-gray-50 dark:bg-gray-800">
                <tr>
                    <th class="px-6 py-4 font-semibold" scope="col">Tiêu đề</th> 
                    <th class="px-6 py-4 font-semibold" scope="col">Tác giả</th> 
                    <th class="px-6 py-4 font-semibold" scope="col">Ngày đăng</th> 
                    <th class="px-6 py-4 font-semibold" scope="col">Trạng thái</th> 
                    <th class="px-6 py-4 font-semibold text-right" scope="col">Hành động</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptArticles" runat="server">
                    <ItemTemplate>
                        <tr class="border-b dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-800/50">
                            <th class="px-6 py-4 font-medium text-gray-900 dark:text-white whitespace-nowrap" scope="row">
                                <%# Eval("TieuDe") %>
                            </th>
                            <td class="px-6 py-4"><%# Eval("TacGia") %></td>
                            <td class="px-6 py-4"><%# Eval("NgayDang", "{0:dd/MM/yyyy}") %></td>
                            <td class="px-6 py-4">
                                <span class='<%# GetStatusClass(Eval("TrangThai").ToString()) %>'>
                                    <%# Eval("TrangThai") %>
                                </span>
                            </td>
                            <td class="px-6 py-4 text-right">
                                <div class="flex justify-end items-center gap-2">
                                    <button type="button" class="p-2 rounded-full hover:bg-blue-100 dark:hover:bg-blue-900/50 text-blue-500">
                                        <span class="material-symbols-outlined text-base">edit</span>
                                    </button>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandArgument='<%# Eval("bv_id") %>' OnClientClick="return confirm('Bạn có chắc muốn xóa?');" CssClass="p-2 rounded-full hover:bg-red-100 dark:hover:bg-red-900/50 text-red-500">
                                        <span class="material-symbols-outlined text-base">delete</span>
                                    </asp:LinkButton>
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
        
        <asp:Label ID="lblNoData" runat="server" Visible="false" CssClass="block p-4 text-center text-gray-500">Không tìm thấy bài viết nào.</asp:Label>
    </div>
</asp:Content>