# How to make UIBarButtonItem and add to Navigation bar

## Single

```swift
    let addBarButton = UIBarButtonItem(systemItem: .add, primaryAction: UIAction(handler: { [weak self]  action in
        print("Add button triggered: \(action)")
        self?.didTapAddButton(action.sender as! UIBarButtonItem)
    }), menu: nil)

    navigationItem.rightBarButtonItem = addBarButton
```

## Multiple

```swift
    let addBarButton = UIBarButtonItem(systemItem: .add, primaryAction: UIAction(handler: { [weak self]  action in
        print("Add button triggered: \(action)")
        self?.didTapAddButton(action.sender as! UIBarButtonItem)
    }), menu: nil)

    let shareBarButton = UIBarButtonItem(systemItem: .action, primaryAction: .init(handler: { [weak self] action in
        guard let self = self else { return }
        
        
        let actionVC = UIActivityViewController(activityItems: ["Hello"], applicationActivities: [])
        
        self.navigationController?.present(actionVC, animated: true, completion: nil)
    }), menu: nil)

    navigationItem.rightBarButtonItems = [addBarButton, shareBarButton]
```

## With Context menu

```swift
    let action1 = UIAction(
        title: "Two",
        image: UIImage(systemName: "2.square")) { [weak self] action in
            print(type(of: action.sender))
            if let sender = action.sender as? UIBarButtonItem {
                print("UIBarButtonItem")
            }
            self?.didTapAddButton(action.sender as! UIBarButtonItem)
            self?.didTapAddButton(action.sender as! UIBarButtonItem)
        }
    
    let action2 = UIAction(
        title: "Three",
        image: UIImage(systemName: "3.square")) { [weak self] action in
            print(type(of: action.sender))
            self?.didTapAddButton(action.sender as! UIBarButtonItem)
            self?.didTapAddButton(action.sender as! UIBarButtonItem)
            self?.didTapAddButton(action.sender as! UIBarButtonItem)
        }
    
    let addBarButtonMenu = UIMenu(
        title: "Add Multiple Items",
        image: UIImage(systemName: "plus.rectangle.on.rectangle"),
        children: [action1, action2])
    
    
    
    let addBarButton = UIBarButtonItem(systemItem: .add, primaryAction: UIAction(handler: { [weak self]  action in
        print("Add button triggered: \(action)")
        self?.didTapAddButton(action.sender as! UIBarButtonItem)
    }), menu: addBarButtonMenu)
    
    navigationItem.rightBarButtonItem = addBarButton

```