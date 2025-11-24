<%@ Page Title="Thông tin cá nhân" Language="C#" MasterPageFile="~/khach_vang_lai/Header.Master" AutoEventWireup="true" CodeBehind="QuanLyThongTinCaNhan.aspx.cs" Inherits="DAN_CS445_AU.khach_hang.QuanLyThongTinCaNhan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.tailwindcss.com?plugins=forms,typography"></script>
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;700;900&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
    
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        "primary": "#4CAF50",
                        "primary-hover": "#388E3C",
                        "bg-light": "#F3F4F6",
                    },
                    fontFamily: {
                        "display": ["Work Sans", "sans-serif"]
                    },
                },
            },
        }
    </script>
    <style>
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24 }
        /* Fix style cho ASP.NET RadioButton */
        .radio-group label { margin-left: 5px; margin-right: 15px; font-size: 0.875rem; color: #374151; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="font-display bg-bg-light text-gray-800 min-h-screen py-8 px-4 sm:px-6">
        <div class="max-w-6xl mx-auto">
            
            <h1 class="text-2xl font-bold text-gray-900 mb-6">Hồ sơ của tôi</h1>

            <asp:Label ID="lblMessage" runat="server" Text="" Visible="false" CssClass="block mb-4 p-4 rounded-lg"></asp:Label>

            <div class="grid grid-cols-1 lg:grid-cols-4 gap-6">
                
                <div class="lg:col-span-1">
                    <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                        <div class="p-4 border-b border-gray-100 flex items-center gap-3">
                            <asp:Image ID="imgAvatarSmall" runat="server" CssClass="w-12 h-12 rounded-full border border-gray-200 object-cover" ImageUrl="https://api.dicebear.com/7.x/avataaars/svg?seed=User" />
                            <div>
                                <p class="text-xs text-gray-500">Tài khoản của</p>
                                <p class="font-bold text-gray-900 truncate">
                                    <asp:Literal ID="litUserNameSide" runat="server"></asp:Literal>
                                </p>
                            </div>
                        </div>
                        <nav class="p-2">
                            <a href="QuanLyThongTinCaNhan.aspx" class="flex items-center gap-3 px-3 py-2.5 bg-green-50 text-primary font-medium rounded-lg mb-1">
                                <span class="material-symbols-outlined text-[20px]">person</span>
                                Thông tin cá nhân
                            </a>
                            <a href="#" class="flex items-center gap-3 px-3 py-2.5 text-gray-600 hover:bg-gray-50 hover:text-gray-900 rounded-lg mb-1 transition-colors">
                                <span class="material-symbols-outlined text-[20px]">receipt_long</span>
                                Đơn mua
                            </a>
                            <a href="#" class="flex items-center gap-3 px-3 py-2.5 text-gray-600 hover:bg-gray-50 hover:text-gray-900 rounded-lg mb-1 transition-colors">
                                <span class="material-symbols-outlined text-[20px]">qr_code_scanner</span>
                                Lịch sử quét QR
                            </a>
                            <a href="#" class="flex items-center gap-3 px-3 py-2.5 text-gray-600 hover:bg-gray-50 hover:text-gray-900 rounded-lg transition-colors">
                                <span class="material-symbols-outlined text-[20px]">logout</span>
                                Đăng xuất
                            </a>
                        </nav>
                    </div>
                </div>

                <div class="lg:col-span-3">
                    <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 md:p-8">
                        
                        <div class="pb-6 border-b border-gray-100 mb-6">
                            <h2 class="text-lg font-bold text-gray-900">Thông tin tài khoản</h2>
                            <p class="text-sm text-gray-500 mt-1">Quản lý thông tin hồ sơ để bảo mật tài khoản</p>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                            
                            <div class="md:col-span-2 space-y-5">
                                
                                <div class="grid grid-cols-1 sm:grid-cols-3 gap-2 items-center">
                                    <label class="text-sm font-medium text-gray-600 sm:text-right sm:pr-4">Tên đăng nhập</label>
                                    <div class="sm:col-span-2">
                                        <asp:TextBox ID="txtUsername" runat="server" ReadOnly="true" Enabled="false" CssClass="w-full text-sm text-gray-500 bg-gray-50 border-gray-300 rounded-lg px-3 py-2 cursor-not-allowed"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="grid grid-cols-1 sm:grid-cols-3 gap-2 items-center">
                                    <label class="text-sm font-medium text-gray-700 sm:text-right sm:pr-4">Họ và tên</label>
                                    <div class="sm:col-span-2">
                                        <asp:TextBox ID="txtHoTen" runat="server" CssClass="w-full text-sm text-gray-900 border-gray-300 rounded-lg focus:ring-primary focus:border-primary px-3 py-2 shadow-sm"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvHoTen" runat="server" ControlToValidate="txtHoTen" ErrorMessage="Vui lòng nhập họ tên" ForeColor="Red" Font-Size="Small" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="grid grid-cols-1 sm:grid-cols-3 gap-2 items-center">
                                    <label class="text-sm font-medium text-gray-700 sm:text-right sm:pr-4">Email</label>
                                    <div class="sm:col-span-2">
                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="w-full text-sm text-gray-900 border-gray-300 rounded-lg focus:ring-primary focus:border-primary px-3 py-2 shadow-sm"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email không hợp lệ" ForeColor="Red" Font-Size="Small" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </div>
                                </div>

                                <div class="grid grid-cols-1 sm:grid-cols-3 gap-2 items-center">
                                    <label class="text-sm font-medium text-gray-700 sm:text-right sm:pr-4">Số điện thoại</label>
                                    <div class="sm:col-span-2">
                                        <asp:TextBox ID="txtPhone" runat="server" CssClass="w-full text-sm text-gray-900 border-gray-300 rounded-lg focus:ring-primary focus:border-primary px-3 py-2 shadow-sm"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="grid grid-cols-1 sm:grid-cols-3 gap-2 items-center">
                                    <label class="text-sm font-medium text-gray-700 sm:text-right sm:pr-4">Giới tính</label>
                                    <div class="sm:col-span-2 flex gap-4 radio-group">
                                        <asp:RadioButton ID="rbNam" runat="server" GroupName="Gender" Text="Nam" Checked="true" />
                                        <asp:RadioButton ID="rbNu" runat="server" GroupName="Gender" Text="Nữ" />
                                        <asp:RadioButton ID="rbKhac" runat="server" GroupName="Gender" Text="Khác" />
                                    </div>
                                </div>

                                <div class="grid grid-cols-1 sm:grid-cols-3 gap-2 items-start">
                                    <label class="text-sm font-medium text-gray-700 sm:text-right sm:pr-4 pt-2">Địa chỉ</label>
                                    <div class="sm:col-span-2">
                                        <asp:TextBox ID="txtDiaChi" runat="server" TextMode="MultiLine" Rows="3" CssClass="w-full text-sm text-gray-900 border-gray-300 rounded-lg focus:ring-primary focus:border-primary px-3 py-2 shadow-sm"></asp:TextBox>
                                    </div>
                                </div>

                            </div>

                            <div class="md:col-span-1 border-l border-gray-100 pl-0 md:pl-8 flex flex-col items-center justify-center">
                                <div class="relative group cursor-pointer mb-4">
                                    <asp:Image ID="imgAvatarBig" runat="server" CssClass="w-28 h-28 rounded-full border-2 border-gray-200 object-cover" ImageUrl="https://api.dicebear.com/7.x/avataaars/svg?seed=User" />
                                </div>
                                
                                <asp:FileUpload ID="fileUploadAvatar" runat="server" CssClass="text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-green-50 file:text-primary hover:file:bg-green-100 mb-2" />
                                
                                <p class="text-xs text-gray-400 mt-3 text-center">
                                    Dụng lượng file tối đa 1 MB<br>Định dạng: .JPEG, .PNG
                                </p>
                            </div>
                        </div>

                        <div class="mt-8 pt-6 border-t border-gray-100">
                            <h3 class="text-md font-bold text-gray-900 mb-4 flex items-center gap-2">
                                <span class="material-symbols-outlined text-gray-400">lock</span>
                                Thay đổi mật khẩu
                            </h3>
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                    <div class="md:col-span-2 space-y-4">
                                    <div class="grid grid-cols-1 sm:grid-cols-3 gap-2 items-center">
                                        <label class="text-sm font-medium text-gray-700 sm:text-right sm:pr-4">Mật khẩu mới</label>
                                        <div class="sm:col-span-2">
                                            <asp:TextBox ID="txtNewPass" runat="server" TextMode="Password" placeholder="Chỉ nhập khi muốn đổi" CssClass="w-full text-sm border-gray-300 rounded-lg focus:ring-primary focus:border-primary px-3 py-2"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="grid grid-cols-1 sm:grid-cols-3 gap-2 items-center">
                                        <label class="text-sm font-medium text-gray-700 sm:text-right sm:pr-4">Xác nhận MK</label>
                                        <div class="sm:col-span-2">
                                            <asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password" CssClass="w-full text-sm border-gray-300 rounded-lg focus:ring-primary focus:border-primary px-3 py-2"></asp:TextBox>
                                            <asp:CompareValidator ID="cvPass" runat="server" ControlToValidate="txtConfirmPass" ControlToCompare="txtNewPass" ErrorMessage="Mật khẩu xác nhận không khớp" ForeColor="Red" Font-Size="Small" Display="Dynamic"></asp:CompareValidator>
                                        </div>
                                    </div>
                                    </div>
                            </div>
                        </div>

                        <div class="mt-8 flex justify-end gap-3 pt-4 border-t border-gray-100">
                            <asp:Button ID="btnCancel" runat="server" Text="Hủy" CssClass="px-6 py-2.5 rounded-lg text-sm font-medium text-gray-600 bg-gray-100 hover:bg-gray-200 transition-colors cursor-pointer border-none" OnClientClick="return false;" />
                            
                            <asp:Button ID="btnSave" runat="server" Text="Lưu thay đổi" OnClick="btnSave_Click" CssClass="px-6 py-2.5 rounded-lg text-sm font-bold text-white bg-primary hover:bg-primary-hover shadow-md transition-all cursor-pointer border-none" />
                        </div>
                        
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>