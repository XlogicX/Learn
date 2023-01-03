# Heading 1

## Heading 2

### Heading 3

#### Heading 4

##### Heading 5

###### Heading 6

Line **breaks** can be ~~done~~ ***acheived*** by adding  
two *spaces* at the end of the line.  

> This is an example of a blockquote
> 
> with multiple lines

1. Ordered
2. List
  1. with
  2. nesting
3. example

- Unordered
- List
  - with
  - nesting
- example

##### Task List
- [ ] Task 1
- [x] Completed Task
- [ ] Task 3

### Example of a code block
    xor eax,eax
    inc ecx
    cmp ecx, #21
    je sub1
    call sub2

---

Or just a code snippet (`xchg edx, ebx`) inline

---

### Example of a code block (fenced with color context with perl)
```perl
use strict;

my $var = "Hello World";
print $var;
```

### Links
- [Basic Markdown Syntax](https://www.markdownguide.org/basic-syntax)
- [Extended](https://www.markdownguide.org/extended-syntax)
- `https://www.maliciousdomain.com/not-a-link`

### Table (XOR)
| A | B | Output |
|:--- |:--- |:---: |
| 0 | 0 | **0** |
| 0 | 1 | **1** |
| 1 | 0 | **1** |
| 1 | 1 | **1** |
