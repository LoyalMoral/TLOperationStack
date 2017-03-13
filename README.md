# TLOperationStack

Apple made NSOperationQueue but didn't make NSOperationStack. Why?

How to use:

1. Check out the code (there are only 2 classes).
2. Import to project.
3. Code:
```
TLOperationStack *operationStack = [[TLOperationStack alloc] init];

TLTask *task = [[TLTask alloc] init];

// require a unique key
task.key = someString;

// set operation
task.operation = [NSBlockOperation blockOperationWithBlock:^{
        // Do something ...
}];
    
// add to stack
[operationStack addTask:task];

// DONE.

```

Feel free to attribute.
