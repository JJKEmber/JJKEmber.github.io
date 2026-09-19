---
title: Feats
layout: page
icon: fas fa-stream
order: 4
category_name: Feats
---

{% assign matching_posts = site.posts | where_exp: "post", "post.categories contains page.category_name" %}
{% assign parent_posts = matching_posts | where_exp: "post", "post.parent == nil or post.parent == empty" %}
{% for post in parent_posts %}
### [{{ post.title }}]({{ post.url | relative_url }})

{{ post.excerpt | strip_html | truncatewords: 40 }}

{% assign child_posts = matching_posts | where: "parent", post.title %}
{% for child in child_posts %}
#### [{{ child.title }}]({{ child.url | relative_url }})

{{ child.excerpt | strip_html | truncatewords: 40 }}
{% endfor %}

{% assign category_posts = matching_posts | where: "parent", page.category_name %}
{% for post in category_posts %}
### [{{ post.title }}]({{ post.url | relative_url }})

{{ post.excerpt | strip_html | truncatewords: 40 }}

{% assign child_posts = matching_posts | where: "parent", post.title %}
{% for child in child_posts %}
#### [{{ child.title }}]({{ child.url | relative_url }})

{{ child.excerpt | strip_html | truncatewords: 40 }}
{% endfor %}
{% endfor %}
{% endfor %}
