MIS = mise exec -- tuist

generate:
	${MIS} install
	${MIS} generate

edit:
	${MIS} edit

clean:
	${MIS} clean

install:
	${MIS} install

graph: 
	${MIS} graph
