import 'package:appchat_flutter/features/app/view_model/app.vm.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppViewModel>.reactive(
      viewModelBuilder: () => AppViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: Text(
            viewModel.categories['label'][viewModel.currentIndex],
            style: Theme.of(context).textTheme.titleMedium,
          ),
          backgroundColor: Colors.white,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFE4E4E7), width: 1),
              ),
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(scrollbars: false),
            child: IndexedStack(
              index: viewModel.currentIndex,
              children: viewModel.categories['widget'].cast<Widget>(),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFE4E4E7), width: 1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(viewModel.categories['icons'].length, (
              index,
            ) {
              return TextButton(
                onPressed: () {
                  viewModel.loadTab(index);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(8),
                  foregroundColor: viewModel.currentIndex == index
                      ? Color(0xFF7851DE)
                      : Colors.grey,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(viewModel.categories['icons'][index], size: 24),
                    SizedBox(height: 4),
                    Text(viewModel.categories['label'][index]),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
