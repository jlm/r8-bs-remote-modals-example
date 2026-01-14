# Creation
This README describes the process I used to create this app. It is included to show
how the framework is built from scratch, rather than just being presented in a finished
form.

Ensure databases r8_bs_remote_modals_example_development and r8_bs_remote_modals_example_test
DO NOT EXIST.

```shell
rails new -d postgresql r8-bs-remote-modals-example
cd r8-bs-remote-modals-example
```
Add slim, foreman, popper_js  and rspec to Gemfile in appropriate sections.

```shell
bundle install
rails db:prepare
rails generate rspec:install
rails generate model product name:string description:text
rails db:migrate
```
Install or edit .gitignore to exclude /.idea/* (RubyMine configuration).

Edit config/routes.rb:
```ruby
  root to: redirect("/products")
  resources :products
```
Install `remote_modal_controller.js` into `app/javascript/controllers/`.
```shell
mkdir app/views/application
```
Install `_remote_modal.html.slim` into `app/views/application/`

```shell
mkdir app/views/products
```
Install `app/views/products/index.html.slim`.
Install `app/controllers/products_controller.rb`.

In `app/views/layouts/application.html.erb`, add a class to the body making it a container with a size, and 
add
```html
<%= turbo_frame_tag "remote_modal", target: "_top" %>
```
at the bottom of the container.  Also include a `stylesheet_link_tag` in the `head` to include the Bootstrap CSS:
```html
<%= stylesheet_link_tag "https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css", integrity: "sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB", crossorigin: "anonymous" %>
```
Get this link from https://getbootstrap.com/docs/5.3/getting-started/download/

Edit `config/importmap.rb` to add:
```ruby
  pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.esm.min.js"
  pin "@popperjs/core", to: "popper.js"
```
Note that it has to be the ESM version of the bootstrap JS because the `bootstrap.min.js` version doesn't have Modal.

Edit app/javascript/application.js and add at the end:
```js
  import "@popperjs/core"
```

Since creating this repository, I have changed the method of including Popper to the same method I use for Bootstrap;
that is, importing it from a CDN.