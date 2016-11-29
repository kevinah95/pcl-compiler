package com.pcl.lexer;

import java.util.Stack;

/**
 * Created by Jose Aguilar Quesada on 11/29/2016.
 */
public class SemanticStack {
    private Stack<StackElement> stack;

    public SemanticStack(){
        stack = new Stack<>();
    }

    public StackElement peek(){
        return stack.peek();
    }

    public void push(StackElement item){
        stack.push(item);
    }

    public StackElement pop(){
        return stack.pop();
    }

    public boolean isEmpty(){
        return stack.empty();
    }

    public int size(){
        return stack.size();
    }
}
