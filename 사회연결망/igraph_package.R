library(igraph)

# graph 타입 데이터 형태
## make_empty_graph() : 빈 graph 타입 데이터를 만들어 준다.
## vertices() : 데이터들 사이의 연결해주는? 함수
## path() : 데이터들 사이의 길을 만들어주거나 지워주는 함수
path
g <- make_empty_graph() + vertices(letters[1:10])
plot(g)
g <- g + path("a","b","c","d")
plot(g)
g <- g + path("e","f","g", weight = 1:2, color = "red")
plot(g)
g <- g + path(c("f","c","j","d"), weight = 1:3, color = "green")
plot(g)

# 항상 graph 함수가 맨 앞에 와야함(순서 바꾸면 오류)
graph <- make_empty_graph() + "foo" + "bar"
plot(graph)

# 원 형태로 연결하기
g <- make_empty_graph() + vertices(letters[1:10])
g <- g + path(letters[1:10], letters[1], color = "gray")
plot(g)

# 여분의 연결선 추가
## V(graph형태의 데이터) :graph데이터의 꼭짓점을 알려주는 함수
## edges() : 관계를 선으로 그려주는 함수, 데이터의 개수가 짝수여야함
### (A,B가 뽑히면 A>B로 연결함 그래서 짝수개여야함)
g <- g + edges(sample(V(g), 10 ,replace = T), color = "red") 
plot(g)


## edge 설정
## add_edges() : graph에 edge를 설정
## set_edge_attr() : edge의 속성 설정
g <- make_empty_graph(n = 5) %>% 
  add_edges(c(1,2, 2,3, 3,4, 4,5)) %>% 
  set_edge_attr("color" , value = "red") %>% 
  add_edges(c(5,1), color = "green")

##E(graph 데이터) : graph 데이터의 구조를 보여준다.
E(g)[[]]
plot(g)

## layout 설정
## add_layout_() : layout을 graph에 추가
(make_star(11) + make_star(11)) %>% 
  add_layout_(as_star(), component_wise("dla")) %>% plot()

