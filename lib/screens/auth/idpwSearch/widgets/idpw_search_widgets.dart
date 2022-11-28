import 'package:flutter/material.dart';

class IdSearch extends StatefulWidget {
  const IdSearch({super.key});

  @override
  State<IdSearch> createState() => _IdSearchState();
}

class _IdSearchState extends State<IdSearch> {
  String email = '';
  String idInqured = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: TextFieldStyle(
                    label: '이메일',
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('조회'),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: Text(
              idInqured.isEmpty ? '조회된 아이디가 없습니다' : '조회된 아이디: $idInqured',
            ),
          )
        ],
      ),
    );
  }
}

class PwSearch extends StatefulWidget {
  const PwSearch({super.key});

  @override
  State<PwSearch> createState() => _PwSearchState();
}

class _PwSearchState extends State<PwSearch> {
  String id = '';
  String password = '';
  String passwordCheck = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                SizedBox(height: 25),
                SizeInListView(
                  child: TextFieldStyle(
                    label: '아이디',
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                SizeInListView(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFieldStyle(
                          label: '이메일',
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(
                        height: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('전송'),
                        ),
                      )
                    ],
                  ),
                ),
                SizeInListView(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFieldStyle(
                          label: '인증코드',
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(
                        height: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('인증'),
                        ),
                      )
                    ],
                  ),
                ),
                SizeInListView(
                  child: TextFieldStyle(
                    label: '새 비밀번호',
                    onChanged: (value) {},
                  ),
                ),
                SizeInListView(
                  child: TextFieldStyle(
                    label: '새 비밀번호 확인',
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('비밀번호 변경'),
          ),
        )
      ],
    );
  }
}

class SizeInListView extends StatelessWidget {
  const SizeInListView({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 60,
        child: child,
      ),
    );
  }
}

class TextFieldStyle extends StatefulWidget {
  const TextFieldStyle({
    super.key,
    required this.label,
    required this.onChanged,
    this.obscure = false,
    this.readOnly = false,
    this.suffixIcon,
  });

  final String label;
  final void Function(String) onChanged;
  final bool obscure;
  final bool readOnly;
  final Widget? suffixIcon;

  @override
  State<TextFieldStyle> createState() => _TextFieldStyleState();
}

class _TextFieldStyleState extends State<TextFieldStyle> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: widget.readOnly,
      obscureText: widget.obscure,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        enabled: !widget.readOnly,
        border: OutlineInputBorder(),
        labelText: widget.label,
        suffixIcon: widget.suffixIcon,
      ),
      style: TextStyle(
        fontStyle: widget.readOnly ? FontStyle.italic : FontStyle.normal,
      ),
    );
  }
}
