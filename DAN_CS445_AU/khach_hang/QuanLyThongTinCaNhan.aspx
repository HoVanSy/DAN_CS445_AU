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

        function confirmCancel() {
            return confirm('Bạn có chắc muốn hủy các thay đổi?');
        }

        function previewAvatar(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('<%= imgAvatarBig.ClientID %>').src = e.target.result;
                    document.getElementById('<%= imgAvatarSmall.ClientID %>').src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
    <style>
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24 }
        .radio-group label { margin-left: 5px; margin-right: 15px; font-size: 0.875rem; color: #374151; }
        .nav-link-active { background-color: #e8f5e9; color: #4CAF50; font-weight: 500; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="font-display bg-bg-light text-gray-800 min-h-screen py-8 px-4 sm:px-6">
        <div class="max-w-6xl mx-auto">
            
            <h1 class="text-2xl font-bold text-gray-900 mb-6">Hồ sơ của tôi</h1>

            <asp:Label ID="lblMessage" runat="server" Text="" Visible="false" CssClass="block mb-4 p-4 rounded-lg"></asp:Label>

            <div class="grid grid-cols-1 lg:grid-cols-4 gap-6">
                
                <!-- Sidebar Navigation -->
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
                            <asp:LinkButton ID="lnkThongTinCaNhan" runat="server" OnClick="lnkThongTinCaNhan_Click" CssClass="flex items-center gap-3 px-3 py-2.5 bg-green-50 text-primary font-medium rounded-lg mb-1">
                                <span class="material-symbols-outlined text-[20px]">person</span>
                                Thông tin cá nhân
                            </asp:LinkButton>
                            <asp:LinkButton ID="lnkDonMua" runat="server" OnClick="lnkDonMua_Click" CssClass="flex items-center gap-3 px-3 py-2.5 text-gray-600 hover:bg-gray-50 hover:text-gray-900 rounded-lg mb-1 transition-colors">
                                <span class="material-symbols-outlined text-[20px]">receipt_long</span>
                                Đơn mua
                            </asp:LinkButton>
                            <asp:LinkButton ID="lnkLichSuQR" runat="server" OnClick="lnkLichSuQR_Click" CssClass="flex items-center gap-3 px-3 py-2.5 text-gray-600 hover:bg-gray-50 hover:text-gray-900 rounded-lg mb-1 transition-colors">
                                <span class="material-symbols-outlined text-[20px]">qr_code_scanner</span>
                                Lịch sử quét QR
                            </asp:LinkButton>
                            <asp:LinkButton ID="lnkDangXuat" runat="server" OnClick="lnkDangXuat_Click" OnClientClick="return confirm('Bạn có chắc muốn đăng xuất?');" CssClass="flex items-center gap-3 px-3 py-2.5 text-gray-600 hover:bg-gray-50 hover:text-gray-900 rounded-lg transition-colors">
                                <span class="material-symbols-outlined text-[20px]">logout</span>
                                Đăng xuất
                            </asp:LinkButton>
                        </nav>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="lg:col-span-3">
                    <asp:MultiView ID="mvContent" runat="server" ActiveViewIndex="0">
                        
                        <!-- View 1: Thông tin cá nhân -->
                        <asp:View ID="viewThongTinCaNhan" runat="server">
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
                                                <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Số điện thoại không hợp lệ" ForeColor="Red" Font-Size="Small" Display="Dynamic" ValidationExpression="^(0|\+84)[0-9]{9,10}$"></asp:RegularExpressionValidator>
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
                                        
                                        <asp:FileUpload ID="fileUploadAvatar" runat="server" onchange="previewAvatar(this);" CssClass="text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-green-50 file:text-primary hover:file:bg-green-100 mb-2" />
                                        
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
                                    <asp:Button ID="btnCancel" runat="server" Text="Hủy" OnClick="btnCancel_Click" OnClientClick="return confirmCancel();" CausesValidation="false" CssClass="px-6 py-2.5 rounded-lg text-sm font-medium text-gray-600 bg-gray-100 hover:bg-gray-200 transition-colors cursor-pointer border-none" />
                                    
                                    <asp:Button ID="btnSave" runat="server" Text="Lưu thay đổi" OnClick="btnSave_Click" CssClass="px-6 py-2.5 rounded-lg text-sm font-bold text-white bg-primary hover:bg-primary-hover shadow-md transition-all cursor-pointer border-none" />
                                </div>
                                
                            </div>
                        </asp:View>

                        <!-- View 2: Đơn mua -->
                        <asp:View ID="viewDonMua" runat="server">
                            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 md:p-8">
                                <div class="pb-6 border-b border-gray-100 mb-6">
                                    <h2 class="text-lg font-bold text-gray-900">Đơn mua của tôi</h2>
                                    <p class="text-sm text-gray-500 mt-1">Quản lý thông tin đơn hàng đã mua</p>
                                </div>

                                <div class="space-y-4">
                                    <asp:Repeater ID="rptDonMua" runat="server">
                                        <ItemTemplate>
                                            <div class="border border-gray-200 rounded-lg p-4 hover:shadow-md transition-shadow">
                                                <div class="flex justify-between items-start mb-3">
                                                    <div>
                                                        <p class="text-sm text-gray-500">Mã đơn: <span class="font-medium text-gray-900">#<%# Eval("Dh_id") %></span></p>
                                                        <p class="text-xs text-gray-400 mt-1"><%# Eval("NgayDat", "{0:dd/MM/yyyy HH:mm}") %></p>
                                                    </div>
                                                    <span class="px-3 py-1 text-xs font-medium rounded-full <%# GetStatusClass(Eval("TrangThai").ToString()) %>">
                                                        <%# Eval("TrangThai") %>
                                                    </span>
                                                </div>
                                                <div class="border-t border-gray-100 pt-3">
                                                    <div class="flex justify-between items-center">
                                                        <p class="text-sm text-gray-600">Tổng tiền: <span class="text-lg font-bold text-primary"><%# Eval("TongTien", "{0:N0}") %> đ</span></p>
                                                        <asp:LinkButton ID="btnXemChiTiet" runat="server" CommandArgument='<%# Eval("Dh_id") %>' OnClick="btnXemChiTiet_Click" CssClass="text-sm text-primary hover:text-primary-hover font-medium">
                                                            Xem chi tiết →
                                                        </asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>

                                    <asp:Panel ID="pnlNoDonMua" runat="server" Visible="false" CssClass="text-center py-12">
                                        <span class="material-symbols-outlined text-gray-300 text-6xl">shopping_cart</span>
                                        <p class="text-gray-500 mt-4">Bạn chưa có đơn hàng nào</p>
                                        <a href="/" class="inline-block mt-4 px-6 py-2.5 bg-primary text-white rounded-lg hover:bg-primary-hover transition-colors">
                                            Mua sắm ngay
                                        </a>
                                    </asp:Panel>
                                </div>
                            </div>
                        </asp:View>

                        <!-- View 3: Lịch sử quét QR -->
                        <asp:View ID="viewLichSuQR" runat="server">
                            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 md:p-8">
                                <div class="pb-6 border-b border-gray-100 mb-6">
                                    <h2 class="text-lg font-bold text-gray-900">Lịch sử quét mã QR</h2>
                                    <p class="text-sm text-gray-500 mt-1">Theo dõi các sản phẩm đã quét mã tra cứu</p>
                                </div>

                                <div class="space-y-4">
                                    <asp:Repeater ID="rptLichSuQR" runat="server">
                                        <ItemTemplate>
                                            <div class="border border-gray-200 rounded-lg p-4 hover:shadow-md transition-shadow">
                                                <div class="flex items-start gap-4">
                                                    <div class="w-16 h-16 bg-gray-100 rounded-lg flex items-center justify-center flex-shrink-0">
                                                        <span class="material-symbols-outlined text-gray-400 text-3xl">qr_code_2</span>
                                                    </div>
                                                    <div class="flex-1">
                                                        <h3 class="font-medium text-gray-900"><%# Eval("TenSanPham") %></h3>
                                                        <p class="text-sm text-gray-500 mt-1">Mã sản phẩm: #<%# Eval("sp_id") %></p>
                                                        <p class="text-xs text-gray-400 mt-1"><%# Eval("NgayQuet", "{0:dd/MM/yyyy HH:mm}") %></p>
                                                    </div>
                                                    <div class="text-right">
                                                        <span class="inline-block px-3 py-1 text-xs font-medium bg-green-100 text-green-700 rounded-full">
                                                            <%# Eval("TrangThai") %>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>

                                    <asp:Panel ID="pnlNoQRHistory" runat="server" Visible="false" CssClass="text-center py-12">
                                        <span class="material-symbols-outlined text-gray-300 text-6xl">qr_code_scanner</span>
                                        <p class="text-gray-500 mt-4">Chưa có lịch sử quét mã QR</p>
                                    </asp:Panel>
                                </div>
                            </div>
                        </asp:View>

                    </asp:MultiView>
                </div>

            </div>
        </div>
    </div>
</asp:Content>