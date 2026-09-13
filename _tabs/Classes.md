---
title: Classes
layout: page
icon: fas fa-archive
order: 3
category_name: Classes
---

{% assign matching_posts = site.posts | where_exp: "post", "post.categories contains page.category_name" %}
{% for post in matching_posts %}
### [{{ post.title }}]({{ post.url | relative_url }})

{{ post.excerpt | strip_html | truncatewords: 40 }}
{% endfor %}
