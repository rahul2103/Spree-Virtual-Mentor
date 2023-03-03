Deface::Override.new(
  virtual_path: 'spree/admin/shared/_main_menu',
  name: 'vendors_main_menu_tabs',
  insert_before: 'erb[silent]:contains("if can? :admin, Spree::Order")',
  text: <<-HTML
    <% if can? :admin, current_store %>
      <ul class="nav nav-sidebar border-bottom" id="sidebarVirtualProjectMentor">
        <%= main_menu_tree Spree.t(:mentor), icon: "users.svg", sub_menu: "mentor", url: "#sidebar-mentor" %>
      </ul>
    <% end %>
  HTML
)
